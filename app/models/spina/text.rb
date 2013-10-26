module Spina
  class Text < ActiveRecord::Base
    has_many :page_parts, as: :page_partable
  end
end
