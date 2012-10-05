require 'constance/config'
require 'pp'

module ActiveSupport
  module Dependencies
    alias_method(:load_missing_constant_constance_renamed, :load_missing_constant)
    undef_method(:load_missing_constant)
    def load_missing_constant(from_mod, const_name)
      puts "Loading missing constant from_module: #{from_mod.inspect} const_name: #{const_name.inspect}\ncaller was:\n#{caller.pretty_inspect}" if Constance.debug? && Constance.verbose?
      result = Constance::Resolver.resolve(from_mod, const_name)
      if result
        puts "Loaded missing constant from_module: #{from_mod.inspect} const_name: #{const_name.inspect} using Constance::Resolver. Got: #{result.inspect}" if Constance.debug?
      else
        result = load_missing_constant_constance_renamed(from_mod, const_name)
        puts "Loaded missing constant from_module: #{from_mod.inspect} const_name: #{const_name.inspect} using ActiveSupport::Dependencies. Got: #{result.inspect}}" if Constance.debug?
      end
      result
    end
  end
end
