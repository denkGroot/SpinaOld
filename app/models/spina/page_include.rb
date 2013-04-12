module Spina
  class PageInclude < ActiveRecord::Base
    attr_accessible :content, :page_id, :page_part_id, :photo_id

    belongs_to :page
    belongs_to :page_part
    belongs_to :photo

    delegate :name, to: :page_part
    delegate :position, to: :page_part
    delegate :content_type, to: :page_part

    validates :page_id, uniqueness: {scope: :page_part_id}

    def to_s
      name
    end

    def content
      content_type == "photo" ? photo : read_attribute(:content)
    end
  end
end
