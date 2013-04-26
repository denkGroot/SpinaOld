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
        html = Redcarpet::Markdown.new(renderer, options).render(text.to_s)

        html.sub!(/\[vimeo\s+(\d*)\]/, '<figure class="video"><iframe src="http://player.vimeo.com/video/\1?portrait=0&title=0&byline=0" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></figure>')
        html.html_safe
      end
    end

    def current_controller?(link_path)
      if controller.controller_name != "pages"
        ['spina', controller.controller_name].join('/') == spina.routes.recognize_path(link_path)[:controller]
      end
    end

    def nav_link(link_text, link_path)
      class_name = (current_page?(link_path) || current_controller?(link_path)) ? 'active' : ''

      content_tag(:li, class: class_name) do
        link_to link_text, link_path
      end
    end

  end
end
