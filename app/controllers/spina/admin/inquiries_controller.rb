module Spina
  module Admin
    class InquiriesController < AdminController

      load_and_authorize_resource class: Inquiry

      def index
        @inquiries = Inquiry.sorted
      end

      def inbox
        @inquiries = Inquiry.new_messages.sorted
      end

      def spam
        @inquiries = Inquiry.spam.order('created_at DESC')
      end

      def mark_as_read
        @inquiry.update_attribute(:archived, true)
        redirect_to inbox_admin_inquiries_path
      end

      def unmark_spam
        @inquiry.ham!
        redirect_to admin_inquiries_path
      end

      def destroy
        @inquiry.destroy
        redirect_to admin_inquiries_path, notice: "Het bericht is verwijderd."
      end
    end
  end
end
