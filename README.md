Constance for Rails 3.x+
=====

A debugging tool, a Rails dependency class resolution tool that uses info from the call stack, or do a pull request and make it do more or less. Constance is wild.

Put `gem 'constance` your Gemfile, `bundle install` and then whenever a constant uses dependencies.rb in Rails 3.x+, you'll see output about the load via `puts "load_missing_constant:\nfrom_mod=#{from_mod.inspect}\nconst_name=#{const_name.inspect}\ncaller:\n#{caller.pretty_inspect}"`.

Then, tweak it to return other classes depending on stack via:

    ActiveSupport::Dependencies.constance = lambda{|from_mod, const_name, caller| some_code_that_returns_class_or_nil }

if `ActiveSupport::Dependencies.constance` returns something, that is considered the constant your were looking for. Otherwise it uses the normal Rails load_missing_constant.

This was to deal with cases in which a local model is named the same as a gem module or classname, etc., if you look at references to /lib/ /app/ or similar within the strings in the caller stack via regexp, you could then return something like `YourModule::TheConflictingModelClass`.

### License

Copyright (c) 2012 Gary S. Weaver, released under the [MIT license][lic].

[lic]: http://github.com/garysweaver/constance/blob/master/LICENSE
