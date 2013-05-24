module Spina
  class PagePart < ActiveRecord::Base

    belongs_to :page
    belongs_to :page_partable, polymorphic: true

    attr_accessible :content_type, :name, :position, :tag, :content, :photo_id, :file, :files_attributes, :photo_ids, :page_id

    mount_uploader :file, FileUploader





    validates_presence_of :name, :content_type, :tag
    validates_inclusion_of :content_type, in: Spina::Engine.config.page_part_types.map(&:to_s), allow_nil: false
    validates_uniqueness_of :tag, scope: :page_id

    accepts_nested_attributes_for :files, allow_destroy: true

    scope :sorted, order(:position)

    def to_s
      name
    end

    def content
      case content_type
      when "photo"
        photo
      when "photos"
        photos
      when "file"
        file
      when "files"
        files
      else
        read_attribute(:content)
      end
    end
  end
end
