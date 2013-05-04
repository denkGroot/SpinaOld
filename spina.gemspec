$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spina/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spina"
  s.version     = Spina::VERSION
  s.authors     = ["Bram Jetten"]
  s.email       = ["bram@denkgroot.com"]
  s.homepage    = "http://www.denkgroot.com"
  s.summary     = "Spina"
  s.description = "CMS"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"
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
  s.add_dependency 'redcarpet'
  s.add_dependency 'neat'
  s.add_dependency 'bourbon'
  s.add_dependency 'client_side_validations'

  s.add_development_dependency "sqlite3"
end
