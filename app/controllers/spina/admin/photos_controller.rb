module Spina
  module Admin
    class PhotosController < AdminController
      
      authorize_resource class: Photo

      add_breadcrumb "Mediabibliotheek", :admin_media_library_path

      layout "spina/admin/media_library"

      def index
        add_breadcrumb "Afbeeldingen", admin_photos_path
        @photos = Photo.sorted
        @photo = Photo.new
      end

      def create
        @photo = Photo.create(photo_params)
      end

      def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy
        redirect_to admin_photos_url
      end

      def enhance
        @photo = Photo.find(params[:id])
        @photo.remote_file_url = params[:new_image]
        @photo.save
      end

      def link
      end

      def photo_select
        @photos = Photo.sorted
        @photo = Photo.new
      end

      def photo_collection_select
        @photos = Photo.sorted
        @photo = Photo.new
      end

      def insert_photo
        @photo = Photo.find(params[:photo_id])
      end

      def insert_photo_collection
        @photos = Photo.find(params[:photo_ids])
      end

      def wysihtml5_insert
        @photo = Photo.find(params[:photo_id])
      end

      def wysihtml5_select
        @photos = Photo.sorted
        @photo = Photo.new
      end

      private

      def photo_params
        params.require(:photo).permit(:file)
      end
      
    end
  end
end
