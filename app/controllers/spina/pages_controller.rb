require_dependency "spina/application_controller"

module Spina
  class PagesController < ApplicationController
    load_and_authorize_resource class: Spina::Page

    def index
      @pages = Page.sorted
    end

    def new
      PagePart.sorted.each do |page_part|
        @page.page_includes.build(page_part_id: page_part.id)
      end
    end

    def create
      if @page.save
        redirect_to pages_url, notice: "Nieuwe pagina is aangemaakt."
      else
        flash[:alert] = "De pagina kan nog niet opgeslagen worden."
        render :new
      end
    end

    def edit
      @page = Page.includes(:page_parts).find(params[:id])

      @page_parts = PagePart.sorted
      @page_parts = @page_parts.where("id not in (?)", @page.page_parts) unless @page.page_parts.empty?

      @page_parts.each do |page_part|
        @page.page_includes.build(page_part_id: page_part.id)
      end

      @page_includes = @page.page_includes.sort_by(&:position)
    end

    def update
      if @page.update_attributes(params[:page])
        redirect_to pages_url
      else
        render :edit
      end
    end

    def destroy
      @page.destroy
      redirect_to pages_url, notice: "De pagina is verwijderd."
    end

    def sort
      params[:page].each_with_index do |id, index|
        Page.update_all({position: index + 1}, {id: id})
      end
      render nothing: true
    end
  end
end
