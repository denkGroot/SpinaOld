module Spina
  class PagePart < ActiveRecord::Base

    belongs_to :page
    belongs_to :page_partable, polymorphic: true, dependent: :destroy

    attr_accessible :page_partable_type, :page_partable_id, :name, :position, :tag, :content, :page_id, :page_partable_attributes

    accepts_nested_attributes_for :page_partable, allow_destroy: true

    validates_presence_of :name, :page_partable_type, :tag
    validates_uniqueness_of :tag, scope: :page_id

    scope :sorted, order(:position)

    def to_s
      name
    end

    def position
      if self.page.present? && Spina::Engine.config.page_parts.keys.include?(self.page.name)
        page_parts = Spina::Engine.config.page_parts[self.page.name]
      else
        page_parts = Spina::Engine.config.default_page_parts
      end
      page_parts.select{|part| part['tag'] == self.tag }.first["position"]
    end

    def content
      if ["Line", "Text"].include? page_partable_type 
        read_attribute(:content)
      else
        self.page_partable.content
      end
    end

    def page_partable_attributes=(attributes)
      if self.page_partable.present?
        self.page_partable.update_attributes(attributes)
      else
        self.page_partable = self.page_partable_type.constantize.create(attributes)
      end
    end

  end
end
