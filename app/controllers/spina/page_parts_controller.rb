require_dependency "spina/application_controller"

module Spina
  class PagePartsController < ApplicationController
    load_and_authorize_resource class: Spina::PagePart

    def index
      @page_parts = PagePart.sorted
    end

    def new
    end

    def create
      if @page_part.save
        redirect_to page_parts_url, notice: "Nieuwe paginasectie is aangemaakt."
      else
        flash[:alert] = "De paginasectie kan nog niet opgeslagen worden."
        render :new
      end
    end

    def edit
    end

    def update
      if @page_part.update_attributes(params[:page_part])
        redirect_to page_parts_url
      end
    end

    def destroy
      @page_part.destroy
      redirect_to page_parts_url, notice: "De paginasectie is verwijderd."
    end

    def sort
      params[:page_part].each_with_index do |id, index|
        PagePart.update_all({position: index + 1}, {id: id})
      end
      render nothing: true
    end
  end
end
