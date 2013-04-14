require_dependency "spina/application_controller"

module Spina
  class InquiriesController < ApplicationController
    load_and_authorize_resource class: Spina::Inquiry

    def index
      @inquiries = Inquiry.sorted
    end

    def mark_as_read
      @inquiry.archived = true
      
      if @inquiry.save
        redirect_to inbox_inquiries_path
      end
    end

    def destroy
      @inquiry.destroy
      redirect_to inquiries_path, notice: "Het bericht is verwijderd."
    end
  end
end
