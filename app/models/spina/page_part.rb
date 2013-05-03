module Spina
  class PagePart < ActiveRecord::Base
    attr_accessible :content_type, :name, :position, :tag, :content, :photo_id, :file, :files_attributes

    mount_uploader :file, FileUploader

    belongs_to :page
    belongs_to :photo
    belongs_to :file
    has_many :files

    validates_presence_of :name, :content_type, :tag
    validates_inclusion_of :content_type, in: Spina.page_part_types.map(&:to_s), allow_nil: false

    accepts_nested_attributes_for :files, allow_destroy: true

    scope :sorted, order(:position)

    def to_s
      name
    end

    def content
      case content_type
      when "photo"
        photo
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
