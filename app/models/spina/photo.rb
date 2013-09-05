module Spina
  class Photo < ActiveRecord::Base
    mount_uploader :file, PhotoUploader

    has_many :page_parts, as: :page_partable
    has_and_belongs_to_many :photo_collections, join_table: 'spina_photo_collections_photos'

    attr_accessible :file

    scope :sorted, -> { order('created_at DESC') }

    validates_presence_of :file

    def name
      file.file.filename
    end

    def content
      self
    end
    
  end
end
