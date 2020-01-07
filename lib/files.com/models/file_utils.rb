module Files
  class FileUtils
    def self.cd(_dir, _options)
      raise NotImplementedError
    end

    def self.chmod(_mode, _list, _options = {})
      raise NotImplementedError
    end

    def self.chmod_R(_mode, _list, _options = {}) # rubocop:disable Naming/MethodName
      raise NotImplementedError
    end

    def self.chown(_user, _group, _list, _options = {})
      raise NotImplementedError
    end

    def self.chown_R(_user, _group, _list, _options = {}) # rubocop:disable Naming/MethodName
      raise NotImplementedError
    end

    def self.cp(src, dest, options = {})
      src = [ src ] if src.is_a? String
      src.each do |path|
        return false if File.directory?(path, options)
      end
      cp_r(src, dest, options)
    end

    def self.cp_r(src, dest, options = {})
      src = [ src ] if src.is_a? String
      src.each do |path|
        FileAction.copy(path, { destination: dest }, options)
      end
    end

    def self.install(src, dest, options = {})
      cp_r(src, dest, options)
    end

    def self.ln(_target, _link, _options = {})
      raise NotImplementedError
    end

    def self.ln_s(_targets, _dir, _options = {})
      raise NotImplementedError
    end

    def self.ln_sf(_target, _link, _options = {})
      raise NotImplementedError
    end

    def self.mkdir(list, params = {}, options = {})
      list = [ list ] if list.is_a? String
      list.each do |path|
        Folder.mkdir(path, params, options) unless File.exist?(path, options)
      end
    end

    def self.mkdir_p(list, options = {})
      list = [ list ] if list.is_a? String

      to_create = list.map do |fname|
        split = fname.split("/")
        accum = ""
        split.map do |piece|
          accum = [ accum, piece ].join("/")
        end
      end.flatten

      mkdir(to_create, options)
    end

    def self.mv(list, dir, options = {})
      list = [ list ] if list.is_a? String
      list.each do |path|
        FileAction.move(path, { destination: dir }, options)
      end
    end

    def self.pwd
      raise NotImplementedError
    end

    def self.rm(list, options = {})
      list = [ list ] if list.is_a? String
      list.each do |fname|
        raise Errno::EPERM.new(fname) if File.directory?(fname, options)
      end
      list.each do |fname|
        File.delete(fname, {}, options)
      end
    end

    def self.rm_r(list, options = {})
      list = [ list ] if list.is_a? String
      list.each do |path|
        File.delete(path, { recursive: true }, options)
      end
    end

    def self.rm_rf(list, options = {})
      rm_r(list, options)
    end

    def self.rmdir(list, options = {})
      list = [ list ] if list.is_a? String
      list.each do |path|
        File.delete(path, {}, options) if File.directory?(path, options)
      end
    end

    def self.touch(_list, _options = {})
      raise NotImplementedError
    end
  end
end
