require "set"

module Files
  # A page of results from a list operation, such as Files::User.list.
  #
  # +each+, and every other Enumerable method, covers the records on this page.
  # +auto_paging_each+ continues through the pages that follow, requesting each
  # one only when iteration reaches it. To move through a list one page at a
  # time, use +has_next_page?+ and +next_page+:
  #
  #   page = Files::User.list(per_page: 100)
  #   loop do
  #     page.each { |user| puts user.username }
  #     break unless page.has_next_page?
  #
  #     page = page.next_page
  #   end
  #
  # A list operation returns its first page without requesting it yet. A page
  # is requested when first used, and enumerating it again reuses its records.
  #
  # The two ways of paging keep separate places. All pages of one list share
  # the place +next_page+ continues from, so calling it on an older page still
  # returns the page after the newest one. +auto_paging_each+ always starts at
  # the page it is called on, follows the cursors from there, and leaves
  # +next_page+ where it was.
  class List
    include Enumerable

    # A requested page: its records, the cursor that requested it, and the
    # cursor the API returned for the page after it, if any.
    Page = Struct.new(:records, :cursor, :next_cursor)

    # Where next_page continues from, shared by all pages of one list.
    Progress = Struct.new(:next_cursor, :requested_cursors)
    private_constant :Page, :Progress

    # The block requests one page. It receives that page's parameters, which
    # are +params+ plus its cursor, and a check to pass on to Api.send_request,
    # so a rejected page leaves the caller's options as they were. +params+
    # itself is copied, not changed.
    def initialize(resource_wrapper, params, &request)
      @resource_wrapper = resource_wrapper
      @params = params.dup
      @params[:per_page] ||= 1_000
      @request = request
      @progress = Progress.new(nil, Set.new)
    end

    # Yields each record on this page and returns the block's results. Without
    # a block, returns an Enumerator.
    def each(&block)
      return enum_for(:each) unless block

      page.records.map(&block)
    end

    # Yields each record on this page and then on each page after it, requesting
    # those pages as iteration reaches them. Without a block, returns a lazy
    # Enumerator, so methods such as +first+ request only the pages they need.
    # This does not change where +next_page+ continues.
    def auto_paging_each(&block)
      return enum_for(:auto_paging_each).lazy unless block

      requested_cursors = Set[page.cursor]
      list = self
      list.page.records.each(&block)
      while (cursor = list.page.next_cursor)
        list = request_list(cursor, requested_cursors)
        list.page.records.each(&block)
      end
    end

    # Whether +next_page+ has another page to return, as reported by the page
    # +next_page+ returned last (the first page, before any call). When stepping
    # with <tt>page = page.next_page</tt>, that is this page.
    def has_next_page?
      page
      !@progress.next_cursor.nil?
    end

    # Requests the page after the last one +next_page+ returned, starting after
    # the first page, so repeated calls on any page of this list walk forward.
    # Once there are no more pages, returns an empty page without a request.
    def next_page
      page
      return with_page(Page.new([], nil, nil)) unless @progress.next_cursor

      list = request_list(@progress.next_cursor, @progress.requested_cursors)
      @progress.next_cursor = list.page.next_cursor
      list
    end

    protected

    attr_writer :page

    def page
      @page ||= request_page(@params[:cursor]).tap do |first_page|
        @progress.requested_cursors << first_page.cursor
        @progress.next_cursor = first_page.next_cursor
      end
    end

    private

    # A cursor this list has already requested would repeat pages, possibly
    # forever, so it ends the list with an error instead. A request that fails
    # can be tried again.
    def request_list(cursor, requested_cursors)
      raise APIConnectionError, "The Files.com API repeated a list cursor, so the SDK stopped requesting pages." if requested_cursors.include?(cursor)

      list = with_page(request_page(cursor))
      requested_cursors << cursor
      list
    end

    def request_page(cursor)
      response, options = @request.call(cursor ? @params.merge(cursor: cursor) : @params) { |reply| reply.require_list(@resource_wrapper) }
      records = response.data.map { |attributes| @resource_wrapper.new(attributes, options) }
      next_cursor = response.http_headers["x-files-cursor"]
      Page.new(records, cursor, (next_cursor unless next_cursor.to_s.strip.empty?))
    end

    def with_page(page)
      dup.tap { |list| list.page = page }
    end
  end
end
