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

module Spina
  class Engine < ::Rails::Engine
    isolate_namespace Spina

    autoload :Plugin, 'spina/plugin'

    def self.require_decorators
      [Rails.root].flatten.map { |p| Dir[p.join('app', 'decorators', '**', '*_decorator.rb')]}.flatten.uniq.each do |decorator|
        Rails.configuration.cache_classes ? require(decorator) : load(decorator)
      end
    end

    config.to_prepare &method(:require_decorators).to_proc
  end
end
