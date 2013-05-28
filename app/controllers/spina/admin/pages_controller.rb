module Spina
  class Admin::PagesController < Admin::ApplicationController
    
    skip_before_filter :verify_authenticity_token, only: [:create, :update]

    load_and_authorize_resource class: Spina::Page, except: [:create, :update]
    load_resource class: Spina::Page

    def index
      @pages = Page.sorted.root_pages.includes(:pages)
    end

    def new
      page_parts = Spina::Engine.config.page_parts.keys.include?(@page.name) ? Spina::Engine.config.page_parts[@page.name] || [] : Spina::Engine.config.default_page_parts
      page_parts.each do |page_part|
        page_part = @page.page_parts.build(page_part)
        page_part.page_partable = page_part.page_partable_type.constantize.new unless ["Text", "Line"].include? page_part.page_partable_type
      end
    end
   
    def create
      @page = Page.new(params[:page])
      if @page.save
        redirect_to admin_pages_url, notice: "Nieuwe pagina is aangemaakt."
      else
        flash[:alert] = "De pagina kan nog niet opgeslagen worden."
        render :new
      end
    end

    def edit      
      page_parts = Spina::Engine.config.page_parts.keys.include?(@page.name) ? Spina::Engine.config.page_parts[@page.name] || [] : Spina::Engine.config.default_page_parts
      page_parts.each do |page_part|        
        unless @page.page_parts.find_index { |x| x.tag == page_part['tag'] }
          page_part = @page.page_parts.build(page_part) 
          page_part.page_partable = page_part.page_partable_type.constantize.new unless ["Text", "Line"].include?(page_part.page_partable_type)
        end
      end
    end

    def update
      # @page = Page.includes(:page_parts).find_by_id(params[:id])

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
        parent_id = id[1] == 'null' ? nil : id[1]
        Page.update_all({position: index + 1, parent_id: parent_id}, {id: id[0]})
      end
      render nothing: true
    end

    private

    def parse_attributes(params)
      parsed_params = params.each_with_object({}) do |(key, value), hash|
        if key == 'page_parts_attributes'
          logger.debug value.inspect
          value = value.reject do |key, value|
            logger.debug value.inspect
            if value.kind_of?(Hash) && value.reject{|key,value| ["name", "tag", "page_partable_type"].include? key }.blank?
              true
            elsif value.kind_of?(Hash) && value['page_partable_attributes'].present? && value['page_partable_attributes'].reject{ |key,value| key == "id"}.blank?
              PagePart.find(value['id']).destroy
              true
            else
              false
            end
          end
        end
        hash[key] = value
      end
      logger.debug "@@@@ params: #{params.inspect}"
      logger.debug "@@@@ parsed_params: #{parsed_params.inspect}"
      parsed_params
    end

  end
end
