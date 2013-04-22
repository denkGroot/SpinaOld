module Spina
  class Admin::InquiriesController < Admin::ApplicationController
    load_and_authorize_resource class: Spina::Inquiry

    def index
      @inquiries = Inquiry.sorted
    end

    def mark_as_read
      @inquiry.archived = true
      
      if @inquiry.save
        redirect_to inbox_admin_inquiries_path
      end
    end

    def destroy
      @inquiry.destroy
      redirect_to admin_inquiries_path, notice: "Het bericht is verwijderd."
    end
  end
end
