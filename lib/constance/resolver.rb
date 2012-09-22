require 'pp'

module Constance
  class Resolver
    # return a constant or if returns nil, Rails will use ActiveSupport::Dependencies.load_missing_constant
    def self.resolve(from_mod, const_name)
      puts "resolve \nfrom_mod=#{from_mod.inspect}\nconst_name=#{const_name.inspect}\ncaller:\n#{caller.pretty_inspect}" if Constance.debug
      caller_search_mapping = Constance.caller_search_mapping
      klass = resolve_by_mapping(from_mod, const_name, caller_search_mapping) if caller_search_mapping
      klass = Constance.proc(from_mod, const_name) if !klass && Constance.proc.is_a? Proc
      klass
    end

    def self.resolve_by_caller_search_mapping(from_mod, const_name, caller_search_mapping)
      caller.each do |line|
        caller_search_mapping.keys.each do |search|
          if search =~ line
            return caller_search_mapping[search][const_name]
          end
        end
      end
    end
  end
end