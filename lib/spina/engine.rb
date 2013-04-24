module Spina
  class Engine < ::Rails::Engine
    isolate_namespace Spina

    require "jquery-rails"
    require 'sass-rails'
    require 'haml'
    require 'compass-rails'
    require 'coffee-rails'
    require 'turbolinks'
    require 'jquery-fileupload-rails'
    require 'cancan'
    require 'carrierwave'
    require 'friendly_id'
    require 'redcarpet'
    require 'neat'
    require 'bourbon'
    require 'plugin'
  end
end
