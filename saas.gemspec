$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "saas/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "saas"
  s.version     = Saas::VERSION
  s.authors     = ["David Van Der Beek"]
  s.email       = ["earlynovrock@gmail.com"]
  s.homepage    = "https://github.com/dvanderbeek/saas"
  s.summary     = "Stripe SaaS billing management."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.2.1"
  s.add_dependency "stripe"#, "~> 4"
  s.add_dependency "stripe_event"

  s.add_development_dependency "pg"
  s.add_development_dependency "devise", ">= 4.7.1"
end
