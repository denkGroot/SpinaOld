module Spina
  class Page < ActiveRecord::Base
    extend FriendlyId

    attr_accessible :deletable, :description, :menu_title, :position, :show_in_menu, :slug, :title, :page_parts_attributes, :parent_id, :name, :seo_title

    friendly_id :title, use: :slugged

    has_many :page_parts, dependent: :destroy
    has_many :pages, foreign_key: :parent_id, dependent: :nullify
    belongs_to :parent, class_name: "Page"

    before_validation :ensure_title

    accepts_nested_attributes_for :page_parts, allow_destroy: true
    validates_presence_of :title

    scope :sorted, -> { order(:position) }
    scope :custom_pages, -> { where(deletable: false) }
    scope :root_pages, -> { where(parent_id: nil) }

    def to_s
      name
    end

    def custom_page?
      !deletable
    end

    def plugin
      Spina::Engine.config.plugins.find { |plugin| plugin.name == name }
    end

    def is_plugin?
      Spina::Engine.config.plugins.any? { |plugin| plugin.name == name }
    end

    def previous_page
      page = Page.sorted.where(parent_id: self.parent_id).where('position < ?', self.position).last
      page != self ? page :nil
    end

    def next_page
      page = Page.sorted.where(parent_id: self.parent_id).where('position > ?', self.position).first
      page != self ? page : nil
    end

    def menu_title
      read_attribute(:menu_title).blank? ? title : read_attribute(:menu_title)
    end

    def seo_title
      read_attribute(:seo_title).blank? ? title : read_attribute(:seo_title)
    end

    def has_content?(page_part)
      content(page_part).present?
    end

    def content(page_part_tag)
      page_part = page_parts.where(tag: page_part_tag).first
      page_part.try(:content)
    end

    private

    def ensure_title
      self.title = self.name.capitalize if self.title.blank? && self.name.present?
    end
  end
end
