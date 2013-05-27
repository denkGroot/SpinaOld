module Spina
  class PhotoCollection < ActiveRecord::Base
    
    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :photos, join_table: 'spina_photo_collections_photos'

    attr_accessible :photos, :photo_ids
    accepts_nested_attributes_for :photos, :allow_destroy => true

  end
end
