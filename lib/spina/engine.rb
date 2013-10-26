require 'haml-rails'
require 'sass-rails'
require 'bourbon'
require 'neat'
require 'coffee-rails'
require 'jquery-rails'
require 'jquery-fileupload-rails'
require 'turbolinks'
require 'carrierwave'
require 'mini_magick'
require 'cancan'
require 'friendly_id'
require 'redcarpet'
require 'negative_captcha'
require 'filters_spam'
require 'ancestry'
require 'breadcrumbs_on_rails'

module Spina
  class Engine < ::Rails::Engine

    isolate_namespace Spina

    def self.require_decorators
      [Rails.root].flatten.map { |p| Dir[p.join('app', 'decorators', '**', '*_decorator.rb')]}.flatten.uniq.each do |decorator|
        Rails.configuration.cache_classes ? require(decorator) : load(decorator)
      end
    end

    config.to_prepare &method(:require_decorators).to_proc
    config.autoload_paths += %W( #{config.root}/lib )

    def self.valid_templates(*pattern)
      ([Rails.root, self.root]).map { |path|
        Dir[path.join(*pattern).to_s].flatten.map { |f|
          File.basename(f).split('.').first
        }
      }.flatten.uniq
    end

  end

  class << self
    @@themes = []

    def register_theme(theme)
      @@themes << theme
    end

    def themes
      @@themes
    end
  end
end
