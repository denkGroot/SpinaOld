module Spina
  class File < ActiveRecord::Base
    attr_accessible :file, :page_id

    belongs_to :page_part

    mount_uploader :file, FileUploader

    validates_presence_of :file

    def name
      file.file.filename
    end
  end
end
