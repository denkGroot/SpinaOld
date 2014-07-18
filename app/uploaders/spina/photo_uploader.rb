# encoding: utf-8
module Spina
  class PhotoUploader < CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    include CarrierWave::MiniMagick

    # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
    # include Sprockets::Helpers::RailsHelper
    # include Sprockets::Helpers::IsolatedHelper

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    version :image do
      process resize_to_fit: [800, 800], if: :too_large?
    end

    # Create different versions of your uploaded files:
    version :thumb do
      process resize_to_fill: [240, 135]
    end

    def too_large?(new_file)
      new_file.size > 120 * 1000
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg gif png)
    end
  end
end
