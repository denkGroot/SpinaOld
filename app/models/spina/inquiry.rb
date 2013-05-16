module Spina
  class Inquiry < ActiveRecord::Base
    attr_accessible :archived, :email, :message, :name, :phone

    validates_presence_of :email, :message, :name
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    filters_spam({
      author_field: :name,
      :other_fields => [],
      :extra_spam_words => %w()
    })


    scope :new_messages, ham.where(archived: false)
    scope :sorted, ham.order("created_at DESC")

  end
end
