module Spina
  class Page < ActiveRecord::Base
    extend FriendlyId

    attr_accessible :deletable, :description, :menu_title, :position, :show_in_menu, :slug, :title, :page_parts_attributes

    friendly_id :title, use: :slugged

    has_many :page_parts

    accepts_nested_attributes_for :page_parts, allow_destroy: true

    validates_presence_of :title

    scope :sorted, order(:position)

    def to_s
      title
    end

    def custom_page?
      !deletable
    end

    def menu_title
      if read_attribute(:menu_title).blank?
        title
      else
        read_attribute(:menu_title)
      end
    end

    def has_content?(page_part)
      content(page_part).present?
    end

    def content(page_part)
      page_part = page_parts.where('spina_page_parts.tag = ?', page_part.to_s).first
      page_part.content if page_part
    end
  end
end
