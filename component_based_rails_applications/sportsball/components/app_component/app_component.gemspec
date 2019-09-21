$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "app_component/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "app_component"
  spec.version     = AppComponent::VERSION
  spec.authors     = ["Grzegorz Milanowski"]
  spec.summary     = "Summary of AppComponent."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "6.0.0"
  spec.add_dependency "slim-rails", "3.2.0"
  spec.add_dependency "trueskill"

  spec.add_development_dependency "sqlite3"
end
