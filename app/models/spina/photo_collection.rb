module Spina
  class PhotoCollection < ActiveRecord::Base
    
    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :photos, join_table: 'spina_photo_collections_photos'

    attr_accessible :photos, :photo_ids
    accepts_nested_attributes_for :photos, :allow_destroy => true

    alias_method :old_update_attributes, :update_attributes
    def update_attributes(attributes)
      self.photos.clear if attributes.reject{|key,value| key == "id" }.blank?
      attributes[:photo_ids] = attributes[:photo_ids].split(",") if attributes[:photo_ids].instance_of? String
      old_update_attributes(attributes)
    end

  end
end
