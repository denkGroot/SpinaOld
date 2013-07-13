module Spina
  module ApplicationHelper
    
    def markdown(text)
      sha = Digest::SHA1.hexdigest(text.to_s)
      Rails.cache.fetch sha do
        renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: false)
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
        html.sub!(/\[button\s+(.*)\](.*)\[\/button\]/, '<a href="\1" class="button">\2</a>')
        html.html_safe
      end
    end

    def current_plugin?(link_path)
      ['spina', controller.controller_name].join('/') == spina.routes.recognize_path(link_path)[:controller]
    end

    def nav_link_class(page)
      "active" if active_page?(page) || page.pages.any? { |child_page| active_page?(child_page) || child_page.pages.any? { |child_child_page| active_page?(child_child_page) } }
    end

    def active_page?(page)
      if current_page?(root_path) && page.name == 'homepage'
        true
      elsif page.is_plugin? 
        plugin = Spina::Engine.config.plugins.select { |plugin| plugin.name == page.name }
        current_plugin?(url_for(plugin[0].path || plugin[0].controller))
      else
        current_page?(url_for(page))
      end
    end

    def link_to_add_fields(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
      end
      link_to(name, '#', class: "add_fields button button-primary button-link", data: {id: id, fields: fields.gsub("\n", ""), icon: '&'})
    end

    def current_account
      @current_account ||= Account.first
    end

  end
end
