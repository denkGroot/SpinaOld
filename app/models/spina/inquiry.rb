module Spina
  class Inquiry < ActiveRecord::Base
    attr_accessible :archived, :email, :message, :name, :phone

    validates_presence_of :email, :message, :name
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    scope :new_messages, where(archived: false)
    scope :sorted, order("created_at DESC")
  end
end
