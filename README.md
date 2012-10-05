Constance for Rails 3.x+
=====

Debug or override Rails 3.x+ constant loading.

### Installation

Put this in your Gemfile:

    gem 'constance', :git => 'git://github.com/garysweaver/constance.git'

Do:

    bundle install

### Configuration

In `application.rb` just above your application and after the Bundler config, add the Constance configuration, e.g.:

    ...
    
    # Debug class/module loading without stacks
    Constance.configure do
      self.debug = true
      self.verbose = false
    end
    
    module MyRailsApp
      class Application < Rails::Application
      ...

You can configure on one line like:

    Constance.debug = true

    Constance.verbose = true
    
    Constance.proc = lambda{|from_mod, const_name| puts "my lambda was called from_mod=#{from_mod.inspect} const_name=#{const_name.inspect} caller: #{caller.inspect} and I can return any class or constant I want, or call some other class or method. But, for kicks I'll return nil"; nil}
    
    Constance.caller_search_mapping = {/(\/app\/|\/lib\/)/ => {'Journey' => 'Fantastic::Journey'}} # go through the caller stack to see if was called from a local or gem file that had app or lib in the path

or using a block:

    Constance.configure do
      self.debug = true
      self.verbose = true
      self.proc = lambda{|from_mod, const_name| puts "my lambda was called from_mod=#{from_mod.inspect} const_name=#{const_name.inspect} caller: #{caller.inspect} and I can return any class or constant I want, or call some other class or method. But, for kicks I'll return nil"; nil}
      self.caller_search_mapping = {/(\/app\/|\/lib\/)/ => {'Journey' => 'Fantastic::Journey'}} # go through the caller stack to see if was called from a local or gem file that had app or lib in the path
    end

### Example

Non-verbose debug logging:

    Loaded missing constant from_module: Object const_name: :Foo using ActiveSupport::Dependencies. Got: Foo
    Loaded missing constant from_module: Object const_name: :ApplicationController using ActiveSupport::Dependencies. Got: ApplicationController
    Loaded missing constant from_module: InheritedResources const_name: :Base using ActiveSupport::Dependencies. Got: InheritedResources::Base
    Loaded missing constant from_module: Object const_name: :Bar using ActiveSupport::Dependencies. Got: Bar
    Loaded missing constant from_module: Object const_name: "Foobar" using ActiveSupport::Dependencies. Got: Foobar

### License

Copyright (c) 2012 Gary S. Weaver, released under the [MIT license][lic].

[lic]: http://github.com/garysweaver/constance/blob/master/LICENSE
