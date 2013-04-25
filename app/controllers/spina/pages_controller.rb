require_dependency "spina/application_controller"

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
      @page.deletable ? render(:show) : method(@page.title.downcase).call
    end

  end
end
