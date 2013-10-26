module Spina
  module Admin
    class InquiriesController < AdminController

      authorize_resource class: Inquiry

      layout "spina/admin/messages"

      def index
        add_breadcrumb "Alle berichten", admin_inquiries_path
        @inquiries = Inquiry.sorted
      end

      def inbox
        add_breadcrumb "Inbox", inbox_admin_inquiries_path
        @inquiries = Inquiry.new_messages.sorted
      end

      def spam
        add_breadcrumb "Alle berichten", admin_inquiries_path
        add_breadcrumb "Spam", spam_admin_inquiries_path
        @inquiries = Inquiry.spam.order('created_at DESC')
      end

      def mark_as_read
        @inquiry = Inquiry.find(params[:id])
        @inquiry.update_attribute(:archived, true)
        redirect_to inbox_admin_inquiries_path
      end

      def unmark_spam
        @inquiry = Inquiry.find(params[:id])
        @inquiry.ham!
        redirect_to admin_inquiries_path
      end

      def destroy
        @inquiry = Inquiry.find(params[:id])
        @inquiry.destroy
        redirect_to admin_inquiries_path, notice: "Het bericht is verwijderd."
      end

      private

      def inquiry_params
        params.require(:inquiry).permit(:archived, :email, :message, :name, :phone)
      end
    end
  end
end
