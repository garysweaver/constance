# -*- encoding: utf-8 -*-  
$:.push File.expand_path("../lib", __FILE__)  
require "constance/version" 

Gem::Specification.new do |s|
  s.name        = 'constance'
  s.version     = Constance::VERSION
  s.authors     = ['Gary S. Weaver']
  s.email       = ['garysweaver@gmail.com']
  s.homepage    = 'https://github.com/garysweaver/constance'
  s.summary     = %q{Stuff with Rails constants.}
  s.description = 'Stuff with Rails constants'
  s.files = Dir['lib/**/*'] + ['Rakefile', 'README.md']
  s.license = 'MIT'
end
