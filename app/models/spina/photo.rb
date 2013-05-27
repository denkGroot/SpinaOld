module Spina
  class Photo < ActiveRecord::Base

    has_many :page_parts, as: :page_partable
    has_and_belongs_to_many :photo_collections, join_table: 'spina_photo_collections_photos'

    attr_accessible :file

    mount_uploader :file, PhotoUploader

    validates_presence_of :file

    def name
      file.file.filename
    end
  end
end
