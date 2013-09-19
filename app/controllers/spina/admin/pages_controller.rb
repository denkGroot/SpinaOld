module Spina
  module Admin
    class PagesController < AdminController

      add_breadcrumb "Pagina's", :admin_pages_path

      load_and_authorize_resource class: Page

      layout "spina/admin/website"

      def index
        @pages = Page.sorted.roots
      end

      def new
        add_breadcrumb "Nieuwe pagina"

        @page_parts = current_theme.page_parts
        @page_parts = @page_parts.map do |page_part|
          page_part = @page.page_parts.build(page_part)
          page_part.page = @page
          page_part.page_partable = page_part.page_partable_type.constantize.new unless ["Text", "Line"].include? page_part.page_partable_type
          page_part
        end
        @page_parts

      end

      def create
        add_breadcrumb "Nieuwe pagina"
        if @page.save
          redirect_to admin_pages_url, notice: "#{@page.title} is aangemaakt."
        else
          @page_parts = @page.page_parts
          @page_parts = @page_parts.map do |page_part|
            page_part.page = @page
            page_part
          end
          render :new
        end
      end

      def edit
        add_breadcrumb @page.title
        
        @page_parts = current_theme.page_parts
        @page_parts = @page_parts.map do |page_part|
          page_part = @page.page_parts.where(name: page_part[:name]).limit(1).first || @page.page_parts.build(page_part)
          page_part.page_partable = page_part.page_partable_type.constantize.new() unless page_part.page_partable.present? ||["Text", "Line"].include?(page_part.page_partable_type)
          page_part
        end
      end

      def update
        add_breadcrumb @page.title
        if @page.update_attributes(params[:page])
          respond_to do |format|
            format.html { redirect_to admin_pages_url, notice: "#{@page.title} opgeslagen" }
            format.json { respond_with_bip(@page) }
            format.js
          end
        else
          respond_to do |format|
            format.html do
              @page_parts = @page.page_parts
              @page_parts = @page_parts.map do |page_part|
                page_part.page = @page
                page_part
              end
              render :edit
            end
            format.json { respond_with_bip(@page) }
          end
        end
      end

      def sort
        params[:list].each do |id|
          if id[1][:children].present?
            id[1][:children].each do |child|
              if child[1][:children].present?
                child[1][:children].each { |child_child| Page.update(child_child[1][:id], position: child_child[0].to_i + 1, parent_id: child[1][:id]) }
              end
            end
            id[1][:children].each { |child| Page.update(child[1][:id], position: child[0].to_i + 1, parent_id: id[1][:id]) }
          end
          Page.update(id[1][:id], position: id[0].to_i + 1, parent_id: nil)
        end
        render nothing: true
      end

      def destroy
        @page.destroy
        redirect_to admin_pages_url, notice: "De pagina is verwijderd."
      end

    end
  end
end
