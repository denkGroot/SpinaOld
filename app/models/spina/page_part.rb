module Spina
  class PagePart < ActiveRecord::Base
    attr_accessible :content_type, :name, :position, :tag, :content, :photo_id

    belongs_to :page
    belongs_to :photo

    validates_presence_of :name, :content_type, :tag
    validates_inclusion_of :content_type, in: Spina.page_part_types.map(&:to_s), allow_nil: false

    scope :sorted, order(:position)

    def to_s
      name
    end

    def content
      content_type == "photo" ? photo : read_attribute(:content)
    end
  end
end
