module Spina
  class PagesController < FrontendController

    def homepage
      @page = Page.find_by_name("homepage")
      render :homepage
    end

    def show
      @page = Page.find(params[:id])
      @page.custom_page? ? method(@page.name.downcase).call : render(:show)
    end

  end
end
