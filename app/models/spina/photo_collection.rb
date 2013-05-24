module Spina
  class PhotoCollection < ActiveRecord::Base
    
    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :photos

  end
end
