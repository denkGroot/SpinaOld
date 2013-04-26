require_dependency "spina/frontend_controller"

module Spina
  class PagesController < FrontendController

    def homepage
      @page = Page.find_by_title("Homepage")
      render :homepage
    end

    def contact
      @inquiry = Inquiry.new
      render :contact
    end

    def show
      @page = Page.find(params[:id])
      @page.custom_page? ? method(@page.title.downcase).call : render(:show)
    end

  end
end
