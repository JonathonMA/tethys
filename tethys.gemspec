$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tethys/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tethys"
  s.version     = Tethys::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Tethys."
  s.description = "TODO: Description of Tethys."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.2"

  s.add_development_dependency "pg"
end
