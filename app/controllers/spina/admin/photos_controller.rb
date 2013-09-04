module Spina
  module Admin
    class PhotosController < AdminController
      
      load_and_authorize_resource class: Photo

      add_breadcrumb "Mediabibliotheek", :admin_media_library_path

      layout "spina/admin/website"

      def index
        add_breadcrumb "Afbeeldingen", admin_photos_path
        @photos = Photo.all
        @photo = Photo.new
      end

      def create
        @photo = Photo.create(params[:photo])
      end

      def destroy
        @photo.destroy
        redirect_to admin_photos_url
      end

      def enhance
        @photo.remote_file_url = params[:new_image]
        @photo.save
      end

      def link
      end

      def photo_select
      end

      def insert_photo
        @photo = Photo.find(params[:photo_id])
      end
      
    end
  end
end
