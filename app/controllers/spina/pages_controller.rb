module Spina
  class PagesController < ApplicationController

    def homepage
      @page = Page.find_by_name("homepage")
      render :homepage
    end

    def show
      @page = Page.find(params[:id])
      if @page.show_in_menu == false && @page.children.any?
        redirect_to @page.children.first
      else
        @page.custom_page? ? method(@page.name.downcase).call : render(:show)
      end
    end

  end
end
