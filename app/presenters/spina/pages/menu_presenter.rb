# require 'active_support/core_ext/string'
require 'active_support/configurable'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'
require 'active_support/core_ext/hash/slice'

class ActiveSupport::OrderedHash
  def slice_by_index(a, b = nil)  
    k = if a.is_a?(Range)
      keys[a]
    elsif b.nil?
      [keys[a]]
    else
      keys[a,b]
    end
    k.inject({}){|h, k| h[k] = self[k] ; h }
  end
end

module Spina
  module Pages
    class MenuPresenter
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActiveSupport::Configurable

      config_accessor :list_tag, :list_wrapper, :list_item_tag, :list_item_css, :selected_css, :current_css, :first_css, :last_css
      
      self.list_tag = :ul
      self.list_item_tag = :li
      self.list_item_css = nil
      self.list_wrapper = false
      self.selected_css = :selected
      self.current_css = :current
      self.first_css = :first
      self.last_css = :last

      attr_accessor :context, :collection, :current_menu_item
      delegate :output_buffer, :output_buffer=, to: :context

      def initialize(collection, context, current_menu_item=nil)
        @collection = collection
        @context = context
        @current_menu_item = current_menu_item
        @selected_menu_items = [@current_menu_item] + @current_menu_item.try(:ancestors)
      end

      def to_html
        render_list_wrapper(collection) if collection.present?
      end

      private

      def render_list_wrapper(menu_items)
        if menu_items.any?
          if list_wrapper
            content_tag(:div) do
              render_menu_items(menu_items)
            end
          else
            render_menu_items(menu_items)
          end
        end
      end

      def render_menu_items(menu_items)
        content_tag(list_tag) do
          menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
            buffer << render_menu_item(item, index, menu_items.length)
          end
        end
      end

      def render_menu_item(menu_item, index, menu_items_length)
        content_tag(list_item_tag, class: menu_item_css(menu_item[0], index, menu_items_length)) do
          buffer = ActiveSupport::SafeBuffer.new
          buffer << link_to(menu_item[0].title, context.spina.url_for(menu_item[0]))
          buffer << render_list_wrapper(menu_item[1]) 
          buffer
        end
      end

      def selected_item_or_descendant_item_selected?(item)
        selected_item?(item) || descendant_item_selected?(item)
      end

      def descendant_item_selected?(item)
        item.has_children? && item.descendants.any?(&method(:selected_item?))
      end

      # Determine whether the supplied item is the currently open item according to Refinery.
      def selected_item?(item)
        # path = context.request.path
        # path = path.force_encoding('utf-8') if path.respond_to?(:force_encoding)

        # # Ensure we match the path without the locale, if present.
        # if %r{^/#{::I18n.locale}/} === path
        #   path = path.split(%r{^/#{::I18n.locale}}).last.presence || "/"
        # end

        # # First try to match against a "menu match" value, if available.
        # # return true if item.try(:menu_match).present? && path =~ Regexp.new(item.menu_match)

        # # Find the first url that is a string.
        # # url = [item.url]
        # # url << ['', item.url[:path]].compact.flatten.join('/') if item.url.respond_to?(:keys)
        # url = [context.spina.url_for(item)]
        # url = url.last.match(%r{^/#{::I18n.locale.to_s}(/.*)}) ? $1 : url.detect{|u| u.is_a?(String)}

        # # Now use all possible vectors to try to find a valid match
        # [path, URI.decode(path)].include?(url) || path == "/#{item.id}"
      end

      def menu_item_css(menu_item, index, menu_items_length)
        css = []
        css << list_item_css
        css << selected_css if (@selected_menu_items.present? && @selected_menu_items.include?(menu_item) )
        css << current_css if @current_menu_item == menu_item
        css << first_css if index == 0
        css << last_css if index + 1 == menu_items_length

        css.reject(&:blank?).presence
      end

    end
  end
end