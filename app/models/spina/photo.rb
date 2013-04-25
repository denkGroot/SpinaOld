module Spina
  class Photo < ActiveRecord::Base
    attr_accessible :file

    has_many :page_parts

    mount_uploader :file, PhotoUploader

    validates_presence_of :file

    def name
      file.file.filename
    end
  end
end
