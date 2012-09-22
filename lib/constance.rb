require 'constance/version'
require 'constance/railtie'

module Constance
  class << self
    attr_accessor :debug, :proc, :caller_search_mapping
    def configure(&block); yield; end
  end
end
