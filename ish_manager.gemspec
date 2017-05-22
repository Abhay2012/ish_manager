$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ish_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ish_manager"
  s.version     = IshManager::VERSION
  s.authors     = ["piousbox"]
  s.email       = ["piousbox@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of IshManager."
  s.description = "TODO: Description of IshManager."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.1"

  s.add_development_dependency "sqlite3"
end
