module Spina
  module ApplicationHelper
    def markdown(text)
      sha = Digest::SHA1.hexdigest(text.to_s)
      Rails.cache.fetch sha do
        renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
        options = {
          autolink: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          lax_spacing: true,
          strikethrough: true,
          superscript: true
        }
        Redcarpet::Markdown.new(renderer, options).render(text.to_s).html_safe
      end
    end

    def current_controller?(link_path)
      controller.controller_name == spina.routes.recognize_path(link_path)[:controller]
    end

    def nav_link(link_text, link_path)
      class_name = (current_page?(link_path) || current_controller?(link_path)) ? 'active' : ''

      content_tag(:li, class: class_name) do
        link_to link_text, link_path
      end
    end

  end
end
