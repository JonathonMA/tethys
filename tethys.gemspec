$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tethys/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tethys"
  s.version     = Tethys::VERSION
  s.authors     = ["Jonathon M. Abbott"]
  s.email       = ["jma@dandaraga.net"]
  s.homepage    = "https://github.com/JonathonMA/tethys"
  s.summary     = "an SQL Event store"
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.2"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails", ">= 3.0"

  s.add_dependency "oj"
end
