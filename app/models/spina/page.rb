module Spina
  class Page < ActiveRecord::Base
    
    extend FriendlyId
    has_ancestry orphan_strategy: :adopt # i.e. added to the parent of deleted node

    attr_accessible :deletable, :description, :menu_title, :position, :show_in_menu, :slug, :title, :page_parts_attributes, :parent_id, :name, :seo_title, :layout_template, :view_template, :skip_to_first_child, :draft, :link_url

    friendly_id :title, use: :slugged

    has_many :page_parts, dependent: :destroy

    before_validation :ensure_title
    before_create :set_view_template, if: Engine.config.use_view_templates

    accepts_nested_attributes_for :page_parts, allow_destroy: true
    validates_presence_of :title

    scope :sorted, -> { order('position') }
    scope :custom_pages, -> { where(deletable: false) }
    scope :live, -> { where(draft: false) }
    scope :in_menu, -> { where(show_in_menu: true )}

    def to_s
      name
    end

    def custom_page?
      !deletable
    end

    def plugin
      Engine.config.plugins.find { |plugin| plugin.name == name }
    end

    def is_plugin?
      Engine.config.plugins.any? { |plugin| plugin.name == name }
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

    def live?
      !draft?
    end

    private

    def ensure_title
      self.title = self.name.capitalize if self.title.blank? && self.name.present?
    end

    def set_view_template
      self.view_template = self.name if Engine.config.view_template_whitelist.include? self.name
    end

  end
end
