module Spina
  class FrontendController < ApplicationController
    before_filter :get_pages

    private

    def get_pages
      @pages = Page.sorted.root_pages.where(show_in_menu: true)
    end
    
  end
end