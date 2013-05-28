module Spina
  class FileCollection < ActiveRecord::Base

    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :files, join_table: 'spina_file_collections_files'

    attr_accessible :files, :files_attributes
    accepts_nested_attributes_for :files, allow_destroy: true

  end
end
