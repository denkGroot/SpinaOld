module Spina
  class FileCollection < ActiveRecord::Base

    has_one :page_part, as: :page_partable
    has_and_belongs_to_many :files

  end
end
