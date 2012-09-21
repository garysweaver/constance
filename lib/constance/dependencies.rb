require 'pp'

module ActiveSupport
  module Dependencies
    class << self
      attr_accessor :constance = lambda{|from_mod, const_name, caller| puts "load_missing_constant:\nfrom_mod=#{from_mod.inspect}\nconst_name=#{const_name.inspect}\ncaller:\n#{caller.pretty_inspect}"}
    end

    alias_method(:load_missing_constant_constance_renamed, :load_missing_constant)
    undef_method(:load_missing_constant)
    def load_missing_constant(from_mod, const_name)
      ActiveSupport::Dependencies.constance(from_mod, const_name, caller) || load_missing_constant_constance_renamed(from_mod, const_name)
    end
  end
end
