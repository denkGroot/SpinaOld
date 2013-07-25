module Spina
  class PagesController < ApplicationController

    before_action :find_page
    before_action :current_user_can_view_page?

    def homepage
      render_with_templates
    end

    def show
      if should_skip_to_first_child?
        redirect_to first_live_child and return
      elsif page.link_url.present?
        redirect_to page.link_url and return
      end

      render_with_templates
    end

    def load_valid_templates
      @valid_view_templa
    end

  private

    def find_page
      @page ||= case action_name
              when 'homepage'
                Page.where(name: 'homepage').first
              when 'show'
                Page.find(params[:id])
              end
    end

    alias_method :page, :find_page

    def current_user_can_view_page?
      raise ActiveRecord::RecordNotFound unless page.live? || current_user.present?
    end

    def should_skip_to_first_child?
      page.skip_to_first_child && first_live_child
    end

    def first_live_child
      page.children.sorted.live.first
    end

    def render_options_for_template(page)
      render_options = {}
      if Engine.config.use_layout_templates && page.layout_template.present?
        render_options[:layout] = "spina/#{page.layout_template}"
      end
      if Engine.config.use_view_templates && page.view_template.present?
        render_options[:template] = "spina/pages/#{page.view_template}"
      else
        render_options[:template] = "spina/pages/show"
      end
      render_options
    end

    def render_with_templates(page = page, render_options = {})
      render_options.update render_options_for_template(page)
      render render_options
    end


  end
end
