module Spina
  class Gallery < ActiveRecord::Base
    attr_accessible :page_part_id, :photo_id

    belongs_to :photo
    belongs_to :page_part
  end
end
