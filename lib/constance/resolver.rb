require 'constance/config'

module Constance
  class Resolver
    Store = {}

    # return a constant or if returns nil, Rails will use ActiveSupport::Dependencies.load_missing_constant
    def self.resolve(from_mod, const_name)
      if Constance.caller_search_mapping
        puts "#{self.class.name} checking caller stack against caller_search_mapping regular expressions #{Constance.caller_search_mapping.inspect}" if Constance.verbose?
        klass = resolve_by_caller_search_mapping(from_mod, const_name, Constance.caller_search_mapping)
        puts "#{self.class.name} caller_search_mapping did not resolve" if Constance.verbose? && !klass
      end
      if !klass && Constance.proc.is_a?(Proc)
        puts "#{self.class.name} sending from_mod=#{from_mod} and const_name=#{const_name} into proc" if Constance.verbose?
        klass = Constance.proc.call(from_mod, const_name)
        puts "#{self.class.name} proc did not resolve" if Constance.verbose? && !klass
      end
      # if got something and didn't ask to replace it
      if klass && !Store[const_name.to_sym]
        puts "#{self.class.name} setting #{const_name} => #{klass} on ActiveSupport::Dependencies::Reference @store" if Constance.verbose?
        ActiveSupport::Dependencies::Reference.instance_variable_get(:@store)[const_name] = klass if klass
      end
      klass
    end

    def self.resolve_by_caller_search_mapping(from_mod, const_name, caller_search_mapping)
      caller.each do |line|
        caller_search_mapping.keys.each do |search|
          if search =~ line
            puts "#{self.class.name} matched #{search} in #{line}" if Constance.verbose?
            return caller_search_mapping[search][const_name.to_s].try(:constantize)
          end
        end
      end
    end

    def self.will_replace(const)
      Store[const.to_s.to_sym] = const
      begin
        Object.send(:remove_const, const)
      rescue
        puts "#{self.class.name} removed #{const.to_s.to_sym} with:\n#{$!.message}\n#{$!.backtrace}" if Constance.verbose?
      end
    end
  end
end
