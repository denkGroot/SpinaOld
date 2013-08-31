module Spina
  module Admin
    class PhotosController < AdminController
      
      load_and_authorize_resource class: Photo

      add_breadcrumb "Foto's", :admin_photos_path

      layout "spina/admin/website"

      def index
        @photos = Photo.all
        @photo = Photo.new
      end

      def create
        @photo = Photo.create(params[:photo])
      end

      def destroy
        @photo.destroy
        redirect_to admin_photos_url, notice: "De foto is verwijderd."
      end

      def enhance
        @photo.remote_file_url = params[:new_image]
        @photo.save
      end

      def link
      end
      
    end
  end
end
