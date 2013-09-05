module Spina
  class PhotoCollection < ActiveRecord::Base
    
    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :photos, join_table: 'spina_photo_collections_photos'

    attr_accessible :photos, :photo_tokens
    attr_reader :photo_tokens
    accepts_nested_attributes_for :photos, :allow_destroy => true

    def photo_tokens=(ids)
      self.photo_ids = ids.split(",")
    end

    alias_method :old_update_attributes, :update_attributes
    def update_attributes(attributes)
      self.photos.clear if attributes.reject{|key,value| key == "id" }.blank?
      old_update_attributes(attributes)
    end

  end
end
