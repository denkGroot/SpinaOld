require_dependency "spina/application_controller"

module Spina
  class PhotosController < ApplicationController
    load_and_authorize_resource class: Spina::Photo

    def index
      @photos = Photo.all
      @photo = Photo.new
    end

    def create
      @photo = Photo.create(params[:photo])
    end

    def destroy
      @photo.destroy
      redirect_to photos_url, notice: "De foto is verwijderd."
    end

    def enhance
      @photo.remote_file_url = params[:new_image]
      @photo.save
    end 
  end
end
