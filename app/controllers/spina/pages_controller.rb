require_dependency "spina/application_controller"

module Spina
  class PagesController < ApplicationController
    before_filter :get_pages

    def homepage
      @page = Page.find_by_title("Homepage")
    end

    def contact
      @inquiry = Inquiry.new
    end

    def show
      @page = Page.find(params[:id])

      if Spina.special_pages.map(&:to_s).include? @page.title.downcase
        method(@page.title.downcase).call
      else
        render :show
      end
    end

    private

    def get_pages
      @pages = Page.sorted.where(show_in_menu: true)
    end
  end
end
