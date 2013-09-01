module Spina
  module Admin
    class PagesController < AdminController
      
      before_action :load_valid_templates, only: [:new, :edit, :update, :create]
      skip_before_action :verify_authenticity_token, only: [:create, :update]

      add_breadcrumb "Pagina's", :admin_pages_path

      load_and_authorize_resource class: Page

      layout "spina/admin/website"

      def index
        @pages = Page.sorted.roots
      end

      def new
        add_breadcrumb "Nieuwe pagina"
        @page_parts = Engine.config.PAGE_TYPES.keys.include?(@page.name) ? Engine.config.page_parts[@page.name] || [] : Engine.config.default_page_parts
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
          redirect_to admin_pages_url, notice: "Nieuwe pagina is aangemaakt."
        else
          @page_parts = @page.page_parts
          @page_parts = @page_parts.map do |page_part|
            page_part.page = @page
            page_part
          end
          flash.now[:alert] = "De pagina kan nog niet opgeslagen worden."
          render :new
        end
      end

      def edit
        add_breadcrumb @page.title
        @page_parts = Engine.config.PAGE_TYPES.keys.include?(@page.name) ? Engine.config.PAGE_TYPES[@page.name] || [] : Engine.config.default_page_parts
        @page_parts = @page_parts.map do |page_part|        
          page_part = @page.page_parts.where(tag: page_part[:tag]).limit(1).first || @page.page_parts.build(page_part)
          page_part.page_partable = page_part.page_partable_type.constantize.new() unless page_part.page_partable.present? ||["Text", "Line"].include?(page_part.page_partable_type)
          page_part
        end
      end

      def update
        add_breadcrumb @page.title
        if @page.update_attributes(params[:page])
          respond_to do |format|
            format.html { redirect_to admin_pages_url }
            format.js
          end
        else
          @page_parts = @page.page_parts
          @page_parts = @page_parts.map do |page_part|
            page_part.page = @page
            page_part
          end
          flash.now[:alert] = "De pagina kan nog niet opgeslagen worden."
          render :edit
        end
      end

      # Based upon https://github.com/patrickshannon/Nested-Drag-and-Drop-with-Ancestry/blob/master/app/controllers/categories_controller.rb
      def sort
        params[:page].sort { |a, b| a <=> b }.each_with_index do |id, index|
          value = id[1][:id]
          position = id[1][:position]
          position = position.to_i + 1
          parent = id[1][:parent_id]
          parent = nil if parent == 'null'
          Page.update(value, position: position, parent_id: parent)
        end
        render nothing: true
      end

      def destroy
        @page.destroy
        redirect_to admin_pages_url, notice: "De pagina is verwijderd."
      end

      protected

      def load_valid_templates
        @valid_layout_templates = Engine.config.layout_template_whitelist &
                                  Engine.valid_templates('app', 'views', '{layouts,layouts/spina}', '*html*')

        @valid_view_templates = Engine.config.view_template_whitelist &
                                Engine.valid_templates('app', 'views', '{pages,spina/pages}', '*html*')
      end

    end
  end
end
