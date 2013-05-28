module Spina
  class File < ActiveRecord::Base
    
    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :file_collections, join_table: 'spina_file_collections_files'

    attr_accessible :file, :page_id, :_destroy
    attr_accessor :_destroy

    mount_uploader :file, FileUploader

    validates_presence_of :file

    def name
      file.file.filename
    end

    alias_method :old_update_attributes, :update_attributes
    def update_attributes(attributes)
      logger.debug attributes.inspect
      if attributes["_destroy"] == "1" && attributes["file"].blank?
        self.page_part.destroy
      else
        old_update_attributes(attributes)
      end
    end

  end
end
