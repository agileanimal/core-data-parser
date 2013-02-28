# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "core-data-parser"

Gem::Specification.new do |s|
  s.name        = "core-data-parser"
  s.authors     = ["Mark Madsen"]
  s.email       = "growl@agileanimal.com"
  s.homepage    = "http://agileanimal.com"
  s.version     = CoreDataParser::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "CoreDataParser"
  s.description = "Automatically generate Active Record for Core Data models."

  s.add_development_dependency "rspec", "~> 2.11.0"
  s.add_development_dependency "rake",  "~> 10.0.3"

  s.add_dependency "nokogiri", "~> 1.5.6"
  s.add_dependency "thor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
