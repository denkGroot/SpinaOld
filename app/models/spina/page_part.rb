module Spina
  class PagePart < ActiveRecord::Base
    attr_accessible :content_type, :name, :position, :tag

    has_many :page_includes, dependent: :destroy
    has_many :pages, through: :page_includes

    validates_presence_of :name, :content_type, :tag
    validates :name, uniqueness: {scope: :tenant_id}

    scope :sorted, order(:position)

    def to_s
      name
    end
  end
end
