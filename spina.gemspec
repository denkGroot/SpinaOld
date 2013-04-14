$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spina/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spina"
  s.version     = Spina::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Spina."
  s.description = "TODO: Description of Spina."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails", '2.1.4'
  s.add_dependency "sass-rails", '~> 3.2.3'
  s.add_dependency "coffee-rails"
  s.add_dependency "compass-rails"
  s.add_dependency "turbolinks"
  s.add_dependency "jquery-fileupload-rails"
  s.add_dependency "haml"
  s.add_dependency "cancan"
  s.add_dependency 'bcrypt-ruby', '~> 3.0.0'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'friendly_id'

  s.add_development_dependency "sqlite3"
end
