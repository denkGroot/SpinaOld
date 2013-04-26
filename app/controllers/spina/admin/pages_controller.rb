module Spina
  class Admin::PagesController < Admin::ApplicationController
    load_and_authorize_resource class: Spina::Page

    def index
      @pages = Page.sorted
    end

    def new
      Spina.default_page_parts.each do |page_part|
        @page.page_parts.build page_part
      end
    end

    def create
      if @page.save
        redirect_to admin_pages_url, notice: "Nieuwe pagina is aangemaakt."
      else
        flash[:alert] = "De pagina kan nog niet opgeslagen worden."
        render :new
      end
    end

    def edit
      @page = Page.includes(:page_parts).find(params[:id])

      page_parts = Spina.page_parts.keys.include?(@page.title.downcase) ? Spina.page_parts[@page.title.downcase] || [] : Spina.default_page_parts
      page_parts.each do |page_part|
        @page.page_parts.build(page_part) unless @page.page_parts.find_index { |x| x.tag == page_part['tag'] }
      end
    end

    def update
      if @page.update_attributes(params[:page])
        redirect_to admin_pages_url
      else
        flash[:alert] = "De pagina kan nog niet opgeslagen worden."
        render :edit
      end
    end

    def destroy
      @page.destroy
      redirect_to admin_pages_url, notice: "De pagina is verwijderd."
    end

    def sort
      params[:page].each_with_index do |id, index|
        Page.update_all({position: index + 1}, {id: id})
      end
      render nothing: true
    end
  end
end
