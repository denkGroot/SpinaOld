module Spina
  class PagePart < ActiveRecord::Base
    include ApplicationHelper

    belongs_to :page
    belongs_to :page_partable, polymorphic: true, dependent: :destroy

    attr_accessible :page_partable_type, :page_partable_id, :name, :title, :position, :content, :page_id, :page_partable_attributes
    accepts_nested_attributes_for :page_partable, allow_destroy: true
    attr_accessor :position

    validates_presence_of :name, :page_partable_type, :title
    validates_uniqueness_of :name, scope: :page_id

    scope :sorted, -> { order(:position) }

    def to_s
      name
    end

    def position
      page_parts = current_theme.view_templates[self.page.view_template || "show"][:page_parts]
      page_parts.index { |page_part| page_part == self.name }.to_i
    end

    def content
      self.page_partable.try(:content) || self.page_partable
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
