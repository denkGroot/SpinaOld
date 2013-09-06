module Spina
  module Admin
    class AttachmentsController < AdminController

      load_and_authorize_resource class: Attachment

      add_breadcrumb "Mediabibliotheek", :admin_media_library_path

      layout "spina/admin/media_library"

      def index
        add_breadcrumb "Documenten", admin_attachments_path
        @attachments = Attachment.file_attached.sorted
        @attachment = Attachment.new
      end

      def create
        @attachment = Attachment.create(params[:attachment])
      end

      def destroy
        @attachment.destroy
        redirect_to admin_attachments_url
      end

      def select
        @attachments = Attachment.file_attached.sorted
        @attachment = Attachment.new
      end

      def insert
        @attachment = Attachment.find(params[:attachment_id])
      end
    end
  end
end
