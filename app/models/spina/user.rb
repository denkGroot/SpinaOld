module Spina
  class User < ActiveRecord::Base
    attr_accessible :admin, :email, :name, :password_digest, :password, :password_confirmation, :last_logged_in

    has_secure_password

    validates_presence_of :name, :email
    validates_presence_of :password, on: :create
    validates_uniqueness_of :email

    def admin?
      admin
    end

    def to_s
      name
    end

    def update_last_logged_in!
      self.last_logged_in = Time.now
      self.save!
    end
  end
end
