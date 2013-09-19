module Spina
  class PagesController < ApplicationController
    before_action :find_page
    before_action :current_user_can_view_page?

    def homepage
      render_with_templates
    end

    def show
      if should_skip_to_first_child?
        if page.is_root?
          redirect_to subpage_path(page, first_live_child) and return
        else
          redirect_to third_level_page_path(page.parent, page, first_live_child) and return
        end
      elsif page.link_url.present?
        redirect_to page.link_url and return
      end

      render_with_templates
    end

  private

    def find_page
      @page ||= case action_name
              when 'homepage'
                Page.where(name: 'homepage').first || Page.first
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
      render_options[:template] = "spina/pages/#{page.view_template}"
      render_options
    end

    def render_with_templates(page = page, render_options = {})
      render_options.update render_options_for_template(page)
      render render_options
    end
  end
end
