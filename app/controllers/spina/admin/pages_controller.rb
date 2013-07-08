module Spina
  module Admin
    class PagesController < AdminController
      
      skip_before_filter :verify_authenticity_token, only: [:create, :update]

      load_and_authorize_resource class: Page#, except: [:create, :update]
      # load_resource class: Page

      def index
        @pages = Page.sorted.root_pages.includes(:pages)
      end

      def new
        @page_parts = Spina::Engine.config.PAGE_TYPES.keys.include?(@page.name) ? Spina::Engine.config.page_parts[@page.name] || [] : Spina::Engine.config.default_page_parts
        @page_parts = @page_parts.map do |page_part|
          page_part = @page.page_parts.build(page_part)
          page_part.page = @page
          page_part.page_partable = page_part.page_partable_type.constantize.new unless ["Text", "Line"].include? page_part.page_partable_type
          page_part
        end
        @page_parts

      end
     
      def create
        if @page.save
          redirect_to admin_pages_url, notice: "Nieuwe pagina is aangemaakt."
        else
          @page_parts = @page.page_parts
          @page_parts = @page_parts.map do |page_part|
            page_part.page = @page
            page_part
          end
          flash[:alert] = "De pagina kan nog niet opgeslagen worden."
          render :new
        end
      end

      def edit      
        @page_parts = Spina::Engine.config.PAGE_TYPES.keys.include?(@page.name) ? Spina::Engine.config.PAGE_TYPES[@page.name] || [] : Spina::Engine.config.default_page_parts
        @page_parts = @page_parts.map do |page_part|        
          page_part = @page.page_parts.where(tag: page_part[:tag]).limit(1).first || @page.page_parts.build(page_part)
          page_part.page_partable = page_part.page_partable_type.constantize.new() unless page_part.page_partable.present? ||["Text", "Line"].include?(page_part.page_partable_type)
          page_part
        end
      end

      def update
        if @page.update_attributes(params[:page])
          redirect_to admin_pages_url
        else
          @page_parts = @page.page_parts
          @page_parts = @page_parts.map do |page_part|
            page_part.page = @page
            page_part
          end
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
          parent_id = id[1] == 'null' ? nil : id[1]
          Page.where(id: id[0]).update_all({position: index + 1, parent_id: parent_id})
        end
        render nothing: true
      end
    end
  end
end
