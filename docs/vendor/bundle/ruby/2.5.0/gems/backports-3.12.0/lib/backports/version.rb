module Backports
  VERSION = "3.12.0" unless const_defined? :VERSION # the guard is against a redefinition warning that happens on Travis
end
