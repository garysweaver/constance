Constance for Rails 3.x+
=====

*Not yet working, I'm afraid. Will work on later probably, but pull requests welcome.*

Hooks into and can override Rails 3.x+ constant loading.

### Installation

Put this in your Gemfile:

    gem 'constance', :git => 'git://github.com/garysweaver/constance.git'

Do:

    bundle install

This will just add something that 

### Configuration

In `config/application.rb` or wherever makes sense either do one or more of these:

    Constance.debug = true

    # Use a proc or lambda to resolve or do something only when classes are looked up
    Constance.proc = lambda{|from_mod, const_name, caller| puts "my lambda was called from_mod=#{from_mod.inspect} const_name=#{const_name.inspect} caller: #{caller.inspect}"}
    
    # Let your local Journey class override the Rails 3.2 Journey class when referred to indirectly or directly via /app/ or /lib/ code.
    Constance.caller_search_mapping = {/(\/app\/|\/lib\/)/ => {'Journey' => Fantastic::Journey}}

or:

    Constance.configure do
      debug = true
      Constance.proc = lambda{|from_mod, const_name, caller| puts "my lambda was called from_mod=#{from_mod.inspect} const_name=#{const_name.inspect} caller: #{caller.inspect}"}
      Constance.caller_search_mapping = {/(\/app\/|\/lib\/)/ => {'Journey' => Fantastic::Journey}}
    end

### Yet to do

To actually resolve classes only when caller includes /app/ or /lib/ as described above, may need to override Rails' autoloading, or uncache the class each time via proc, or use your own class registry, or do a pull request and I can add something.

Also could list the app/models/fantastic directory, get the names and convert them to classnames without using constantize so it won't do class resolution, put them in an array, and add a 'ModelName' => Fantastic::ModelName hash for the search mapping.

### License

Copyright (c) 2012 Gary S. Weaver, released under the [MIT license][lic].

[lic]: http://github.com/garysweaver/constance/blob/master/LICENSE
