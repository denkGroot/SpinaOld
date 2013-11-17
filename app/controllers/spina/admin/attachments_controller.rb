module Spina
  module Admin
    class AttachmentsController < AdminController
      before_filter :set_breadcrumbs

      authorize_resource class: Attachment

      layout "spina/admin/media_library"

      def index
        add_breadcrumb "Documenten", spina.admin_attachments_path
        @attachments = Attachment.file_attached.sorted
        @attachment = Attachment.new
      end

      def create
        @attachment = Attachment.create(attachment_params)
      end

      def destroy
        @attachment = Attachment.find(params[:id])
        @attachment.destroy
        redirect_to spina.admin_attachments_url
      end

      def select
        @attachments = Attachment.file_attached.sorted
        @attachment = Attachment.new
      end

      def insert
        @attachment = Attachment.find(params[:attachment_id])
      end

      def select_collection
        @attachments = Attachment.file_attached.sorted
        @attachment = Attachment.new
      end

      def insert_collection
        @attachments = Attachment.find(params[:attachment_ids])
      end

      private

      def set_breadcrumbs
        add_breadcrumb "Mediabibliotheek", spina.admin_media_library_path
      end

      def attachment_params
        params.require(:attachment).permit(:file, :page_id, :_destroy)
      end
    end
  end
end
