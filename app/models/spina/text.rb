module Spina
  class Text < ActiveRecord::Base
    has_many :page_parts, as: :page_partable

    attr_accessible :content
  end
end
