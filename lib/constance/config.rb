module Constance
  OPTIONS = [
    :caller_search_mapping,
    :debug,
    :verbose,
    :proc
  ]
  
  class << self
    OPTIONS.each{|o|attr_accessor o; alias_method "#{o}?".to_sym, o}
    def configure(&blk); class_eval(&blk); end
  end
end
