module Spina
  class File < ActiveRecord::Base
    
    has_many :page_parts, as: :page_partable
    has_and_belongs_to_many :file_collections

    attr_accessible :file, :page_id

    mount_uploader :file, FileUploader

    validates_presence_of :file

    def name
      file.file.filename
    end
  end
end
