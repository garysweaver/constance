Constance for Rails 3.x+
=====

Debug or override Rails 3.x+ constant loading.

### Installation

Put this in your Gemfile:

    gem 'constance', :git => 'git://github.com/garysweaver/constance.git'

Do:

    bundle install

### Configuration

In `config/application.rb` or wherever makes sense either do one or more of these:

    Constance.debug = true

    Constance.proc = lambda{|from_mod, const_name, caller| puts "my lambda was called from_mod=#{from_mod.inspect} const_name=#{const_name.inspect} caller: #{caller.inspect} and I can return any class or constant I want, or call some other class or method. But, for kicks I'll return the Constance module"; Constance}
    
    Constance.caller_search_mapping = {/(\/app\/|\/lib\/)/ => {'Journey' => Fantastic::Journey}} # go through the caller stack to see if was called from a local or gem file that had app or lib in the path

or:

    Constance.configure do
      self.debug = true
      self.proc = lambda{|from_mod, const_name, caller| puts "my lambda was called from_mod=#{from_mod.inspect} const_name=#{const_name.inspect} caller: #{caller.inspect} and I can return any class or constant I want, or call some other class or method. But, for kicks I'll return the Constance module"; Constance}
      self.caller_search_mapping = {/(\/app\/|\/lib\/)/ => {'Journey' => Fantastic::Journey}} # go through the caller stack to see if was called from a local or gem file that had app or lib in the path
    end

### License

Copyright (c) 2012 Gary S. Weaver, released under the [MIT license][lic].

[lic]: http://github.com/garysweaver/constance/blob/master/LICENSE
