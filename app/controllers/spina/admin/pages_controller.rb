module Spina
  module Admin
    class PagesController < AdminController

      before_filter :set_breadcrumb

      authorize_resource class: Page

      layout "spina/admin/website"

      def index
        @pages = Page.active.sorted.roots
      end

      def new
        @page = Page.new
        if current_theme.new_page_templates.any? { |template| template[0] == params[:view_template] }
          @page.view_template = params[:view_template] 
        end
        add_breadcrumb "Nieuwe pagina"
        @page_parts = current_theme.config.page_parts.map { |page_part| @page.page_part(page_part) }
      end

      def create
        @page = Page.new(page_params)
        add_breadcrumb "Nieuwe pagina"
        if @page.save
          redirect_to spina.admin_pages_url, notice: "#{@page.title} is aangemaakt."
        else
          @page_parts = @page.page_parts
          render :new
        end
      end

      def edit
        @page = Page.find(params[:id])
        add_breadcrumb @page.title
        @page_parts = current_theme.config.page_parts.map { |page_part| @page.page_part(page_part) }
      end

      def update
        @page = Page.find(params[:id])
        add_breadcrumb @page.title
        respond_to do |format|
          if @page.update_attributes(page_params)
            format.html { redirect_to spina.admin_pages_url, notice: "#{@page.title} opgeslagen" }
            format.js
          else
            format.html do
              @page_parts = @page.page_parts
              render :edit
            end
          end
        end
      end

      def sort
        params[:list].each do |id|
          if id[1][:children].present?
            id[1][:children].each do |child|
              child[1][:children].each { |child_child| update_page_position(child_child, child[1][:id]) } if child[1][:children].present?
              update_page_position(child, id[1][:id])
            end
          end
          update_page_position(id, nil)
        end
        render nothing: true
      end

      def destroy
        @page = Page.find(params[:id])
        @page.destroy
        redirect_to spina.admin_pages_url, notice: "De pagina is verwijderd."
      end

      private

      def set_breadcrumb
        add_breadcrumb "Pagina's", spina.admin_pages_path
      end

      def update_page_position(page, parent_id = nil)
        Page.update(page[1][:id], position: page[0].to_i + 1, parent_id: parent_id )
      end

      def page_params
        params.require(:page).permit!
      end

    end
  end
end
