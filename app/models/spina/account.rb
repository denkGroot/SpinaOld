module Spina
  class Account < ActiveRecord::Base
    attr_accessible :address, :city, :email, :logo, :name, :phone, :postal_code, :preferences

    serialize :preferences

    mount_uploader :logo, LogoUploader

    def to_s
      name
    end

    private

    def self.serialized_attr_accessor(*args)
      args.each do |method_name|
        eval "
          def #{method_name}
            (self.preferences || {})[:#{method_name}]
          end

          def #{method_name}=(value)
            self.preferences ||= {}
            self.preferences[:#{method_name}] = value
          end
          attr_accessible :#{method_name}
        "
      end
    end

    serialized_attr_accessor :google_analytics, :facebook, :twitter
  end
end
