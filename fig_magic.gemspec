# -*- encoding: utf-8 -*-
require File.expand_path('../lib/fig_magic/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "fig_magic"
  gem.version       = FigMagic::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Justin Commu"]
  gem.email         = ["jcommu@gmail.com"]
  gem.license       = 'MIT'
  gem.homepage      = "http://github.com/tk8817/fig_magic"
  gem.summary       = %q{Combines FigNewton & DataMagic into a single gem & namespace}
  gem.description   = %q{Provides datasets to application stored in YAML files}
  
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'faker', '>= 1.1.2'
  gem.add_dependency 'yml_reader', '>= 0.5'

  gem.add_development_dependency 'rspec', '>= 2.12.0'
  gem.add_development_dependency 'cucumber', '>= 1.2.0'
end
