#puts "ActiveSupport::Dependencies.methods=#{ActiveSupport::Dependencies.methods.collect{|m|m.to_s}}"

module ActiveSupport
  module Dependencies
    alias_method(:load_missing_constant_constance_renamed, :load_missing_constant)
    undef_method(:load_missing_constant)
    def load_missing_constant(from_mod, const_name)
      Constance::Resolver.load_missing_constant(from_mod, const_name) || load_missing_constant_constance_renamed(from_mod, const_name)
    end
  end
end
