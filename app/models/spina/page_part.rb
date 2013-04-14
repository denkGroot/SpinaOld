module Spina
  class PagePart < ActiveRecord::Base
    attr_accessible :content_type, :name, :position, :tag

    has_many :page_includes, dependent: :destroy
    has_many :pages, through: :page_includes

    validates_presence_of :name, :content_type, :tag
    validates_inclusion_of :content_type, in: Spina.page_part_types.map(&:to_s), allow_nil: false

    scope :sorted, order(:position)

    def to_s
      name
    end
  end
end
