require File.expand_path("../lib/moneyjs-rails/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "moneyjs-rails"
  s.version     = Moneyjs::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.files       = Dir["lib/**/*"] + Dir["vendor/**/*"] + ["README.md"]
  s.authors     = ["Philipp Albig"]
  s.email       = ["philipp.albig@pictrs.com"]
  s.homepage    = "https://github.com/philister/moneyjs-rails"
  s.summary     = "A tiny JavaScript library for currency conversing with Rails asset pipeline"
  s.description = ""
  s.license     = "MIT"
end