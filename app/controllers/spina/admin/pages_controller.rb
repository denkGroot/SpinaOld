module Spina
  module Admin
    class PagesController < AdminController

      add_breadcrumb "Pagina's", :admin_pages_path

      authorize_resource class: Page

      layout "spina/admin/website"

      def index
        @pages = Page.sorted.roots
      end

      def new
        @page = Page.new
        add_breadcrumb "Nieuwe pagina"
        @page_parts = current_theme.config.page_parts.map { |page_part| @page.page_part(page_part) }
      end

      def create
        @page = Page.new(page_params)
        add_breadcrumb "Nieuwe pagina"
        if @page.save
          redirect_to admin_pages_url, notice: "#{@page.title} is aangemaakt."
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
            format.html { redirect_to admin_pages_url, notice: "#{@page.title} opgeslagen" }
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
        @page = Page.find(params[:id])
        @page.destroy
        redirect_to admin_pages_url, notice: "De pagina is verwijderd."
      end

      private

      def page_params
        params.require(:page).permit(:deletable, :description, :menu_title, 
                                      :position, :show_in_menu, :slug, :title, 
                                      :parent_id, :name, :seo_title, :layout_template, 
                                      :view_template, :skip_to_first_child, :draft, 
                                      :link_url, :materialized_path, 
                                      page_parts_attributes: 
                                        [:id, :page_partable_type, :page_partable_id, 
                                          :name, :title, :position, :content, :page_id, 
                                          page_partable_attributes: 
                                            [:content, :photo_tokens, :attachment_tokens, :id]])
      end

    end
  end
end
