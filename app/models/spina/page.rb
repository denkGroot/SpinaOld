module Spina
  class Page < ActiveRecord::Base
    extend FriendlyId

    attr_accessible :deletable, :description, :menu_title, :position, :show_in_menu, :slug, :title, :page_includes_attributes

    friendly_id :title, use: :slugged

    has_many :page_includes
    has_many :page_parts, through: :page_includes

    accepts_nested_attributes_for :page_includes, reject_if: proc { |attributes| attributes['page_part_id'].blank? }

    validates_presence_of :title

    scope :sorted, order(:position)

    def to_s
      title
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
      page_include = page_includes.joins(:page_part).where('spina_page_parts.tag = ?', page_part.to_s).first
      page_include.content if page_include
    end
  end
end
