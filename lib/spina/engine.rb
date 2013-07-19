require 'haml-rails'
require 'sass-rails'
require 'bourbon'
require 'neat'
require 'coffee-rails'
require 'jquery-rails'
require 'jquery-fileupload-rails'
require 'turbolinks'
require 'protected_attributes'
require 'carrierwave'
require 'mini_magick'
require 'cancan'
require 'friendly_id'
require 'redcarpet'
require 'negative_captcha'
require 'filters_spam'
require 'awesome_nested_set'

module Spina
  class Engine < ::Rails::Engine

    isolate_namespace Spina

    def self.require_decorators
      [Rails.root].flatten.map { |p| Dir[p.join('app', 'decorators', '**', '*_decorator.rb')]}.flatten.uniq.each do |decorator|
        Rails.configuration.cache_classes ? require(decorator) : load(decorator)
      end
    end

    if Rails.version >= '3.1'
      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w( spina/admin/epiceditor/base.css spina/admin/epiceditor/editor.css spina/admin/epiceditor/preview.css )
      end
    end



    config.to_prepare &method(:require_decorators).to_proc
    config.autoload_paths += %W(#{config.root}/lib)
    
    config.use_view_templates = false
    config.view_template_whitelist = ['home', 'show']
    
    config.use_layout_templates = false
    config.layout_template_whitelist = ['application']

    def self.valid_templates(*pattern)
      ([Rails.root, self.root]).map { |path|
        Dir[path.join(*pattern).to_s].flatten.map { |f|
          File.basename(f).split('.').first
        }
      }.flatten.uniq
    end

  end
end
