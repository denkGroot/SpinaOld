module Spina
  class PagePart < ActiveRecord::Base

    belongs_to :page
    belongs_to :page_partable, polymorphic: true

    attr_accessible :page_partable_type, :page_partable_id, :name, :position, :tag, :content, :page_id, :page_partable_attributes

    # mount_uploader :file, FileUploader

    validates_presence_of :name, :page_partable_type, :tag
    validates_uniqueness_of :tag, scope: :page_id

    scope :sorted, order(:position)

    def to_s
      name
    end

    def content
      if ["Line", "Text"].include? page_partable_type 
        read_attribute(:content)
      else
        self.page_partable.content
      end
    end

    def page_partable_attributes=(attributes)
      self.page_partable = self.page_partable_type.constantize.create(attributes)
    end

  end
end
