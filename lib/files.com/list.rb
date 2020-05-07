module Files
  class List
    include Enumerable

    def initialize(resource_wrapper, params, current_response = nil, current_options = nil, &request_page)
      @resource_wrapper = resource_wrapper
      @params = params
      @current_response = current_response
      @current_options = current_options
      @request_page = request_page
    end

    # Iterates through each resource in all pages, making additional fetches to
    # the API as necessary.
    #
    # Note that this method will make as many API calls as necessary to fetch
    # all resources. For more granular control, please see +each+ and
    # +next_page+.
    def auto_paging_each
      return enum_for(:auto_paging_each).lazy unless block_given?

      loop do
        page = next_page
        break unless page.valid_response?

        page.set_cursor

        page.wrap_data do |data|
          yield data
        end
        break if page.on_last_page?
      end
    end

    # Iterates through each resource in the current page.
    #
    # Note that this method makes no effort to fetch a new page when it gets to
    # the end of the current page's resources. See also +auto_paging_each+.
    def each(&block)
      page = current_page
      return [] unless page.valid_response?

      page.set_cursor
      page.wrap_data { |data| block.call data }
    end

    # Fetches the next page of resources (if there is one).
    #
    # This method will try to respect the per_page set. If none
    # was given, the default per_page will be used.
    def next_page
      self.class.new(resource_wrapper, params, *request_page.call, &request_page)
    end

    protected

    attr_reader :resource_wrapper,
                :params,
                :request_page

    def current_page
      @current_page ||= if @current_response and @current_options
                          self
                        else
                          next_page
                        end
    end

    def data
      @current_response.data
    end

    def wrap_data
      data.map do |object|
        yield resource_wrapper.new(object, @current_options)
      end
    end

    def set_cursor
      params[:cursor] ||= @current_options[:client].cursor
    end

    def cursor
      params[:cursor]
    end

    def valid_response?
      @current_response.http_status == 200
    end

    def on_last_page?
      !cursor or (data.count < params[:per_page])
    end
  end
end
