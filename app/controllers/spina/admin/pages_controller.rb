module Spina
  module Admin
    class PagesController < AdminController
      
      skip_before_filter :verify_authenticity_token, only: [:create, :update]

      load_and_authorize_resource class: Page#, except: [:create, :update]
      # load_resource class: Page

      def index
        @pages = Page.order('lft ASC')
      end

      def new
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
        @page_parts = Engine.config.PAGE_TYPES.keys.include?(@page.name) ? Engine.config.PAGE_TYPES[@page.name] || [] : Engine.config.default_page_parts
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

      # Based upon http://github.com/matenia/jQuery-Awesome-Nested-Set-Drag-and-Drop
      def update_positions
        previous = nil
        params[:ul].each do |_, list|
          list.each do |index, hash|
            moved_item_id = hash['id'][/\d+$/]
            logger.debug hash.inspect
            @current_page = Page.find_by_id(moved_item_id)

            if @current_page.respond_to?(:move_to_root)
              if previous.present?
                @current_page.move_to_right_of(Page.find_by_id(previous))
              else
                @current_page.move_to_root
              end
            else
              @current_page.update_attributes position: index
            end

            if hash['children'].present?
              update_child_positions(hash, @current_page)
            end

            previous = moved_item_id
          end
        end

        Page.rebuild! if Page.respond_to?(:rebuild!)

        after_update_positions
      end

      def update_child_positions(_node, page)
        list = _node['children']['0']
        list.sort_by {|k, v| k.to_i}.map { |item| item[1] }.each_with_index do |child, index|
          child_id = child['id'].split(/page\_?/).reject(&:empty?).first
          child_page = Page.where(:id => child_id).first
          child_page.move_to_child_of(page)

          if child['children'].present?
            update_child_positions(child, child_page)
          end
        end
      end

      def after_update_positions
        render :nothing => true
      end

      protected :after_update_positions


      def destroy
        @page.destroy
        redirect_to admin_pages_url, notice: "De pagina is verwijderd."
      end

    end
  end
end
