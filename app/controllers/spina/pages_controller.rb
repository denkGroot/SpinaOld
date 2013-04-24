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
      @page.deletable ? render :show : method(@page.title.downcase).call
    end

    private

    def get_pages
      @pages = Page.sorted.where(show_in_menu: true)
    end
  end
end
