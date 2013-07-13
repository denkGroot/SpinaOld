module Spina
  class FrontendController < ApplicationController
    before_filter :get_pages

    private

    def get_pages
      @pages = Page.root_pages.sorted.where(show_in_menu: true)
    end
    
  end
end