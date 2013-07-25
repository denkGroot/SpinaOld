module Spina
  class AttachmentCollection < ActiveRecord::Base

    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :attachments, join_table: 'spina_attachment_collections_attachments'

    attr_accessible :attachments, :attachments_attributes
    accepts_nested_attributes_for :attachments, allow_destroy: true

  end
end
