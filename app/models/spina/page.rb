module Spina
  class Page < ActiveRecord::Base
    extend FriendlyId
    
    has_ancestry orphan_strategy: :adopt # i.e. added to the parent of deleted node

    attr_accessible :deletable, :description, :menu_title, :position, :show_in_menu, :slug, :title, :page_parts_attributes, :parent_id, :name, :seo_title, :layout_template, :view_template, :skip_to_first_child, :draft, :link_url, :materialized_path

    friendly_id :slug_candidates, use: [:slugged, :finders]

    has_many :page_parts, dependent: :destroy

    before_validation :ensure_title
    before_save :set_materialized_path
    after_save :save_children

    accepts_nested_attributes_for :page_parts, allow_destroy: true
    validates_presence_of :title, :view_template

    scope :sorted, -> { order('position') }
    scope :custom_pages, -> { where(deletable: false) }
    scope :live, -> { where(draft: false) }
    scope :in_menu, -> { where(show_in_menu: true )}

    def slug_candidates
      [
        :title, 
        [:title, :id]
      ]
    end

    def should_generate_new_friendly_id?
      title_changed?
    end

    def to_s
      name
    end

    def custom_page?
      !deletable
    end

    def set_materialized_path
      self.materialized_path = generate_materialized_path
    end

    def save_children
      self.children.each { |child| child.save }
    end

    def plugin
      # Engine.config.plugins.find { |plugin| plugin.name == name }
    end

    def is_plugin?
      # Engine.config.plugins.any? { |plugin| plugin.name == name }
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

    def content(page_part)
      page_part = page_parts.where(name: page_part).first
      page_part.try(:content)
    end

    def live?
      !draft?
    end

    def previous_sibling
      self.siblings.where('position < ?', self.position).sorted.last
    end

    def next_sibling
      self.siblings.where('position > ?', self.position).sorted.first
    end

    private

    def generate_materialized_path
      case self.depth
      when 0
        "/#{slug}"
      when 1
        "/#{self.parent.slug}/#{slug}"
      when 2
        "/#{self.parent.parent.slug}/#{self.parent.slug}/#{slug}"
      end
    end

    def ensure_title
      self.title = self.name.capitalize if self.title.blank? && self.name.present?
    end

  end
end
