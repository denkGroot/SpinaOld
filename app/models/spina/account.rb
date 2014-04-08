module Spina
  class Account < ActiveRecord::Base
    serialize :preferences

    mount_uploader :logo, LogoUploader

    has_many :layout_parts, dependent: :destroy
    accepts_nested_attributes_for :layout_parts, allow_destroy: true

    after_save :bootstrap_website

    def to_s
      name
    end

    def layout_part(layout_part)
      layout_part = layout_parts.where(name: layout_part[:name]).first || layout_parts.build(layout_part)
      layout_part.layout_partable = layout_part.layout_partable_type.constantize.new unless layout_part.layout_partable.present?
      layout_part
    end

    def content(layout_part)
      layout_part = layout_parts.where(name: layout_part).first
      layout_part.try(:content)
    end

    private

    def bootstrap_website
      theme = ::Spina.theme(self.theme)
      theme.config.custom_pages.each do |page| 
        Page.where(name: page[:name], deletable: false).first_or_create(title: page[:title], view_template: page[:view_template]).activate!
      end
      Page.where.not(view_template: theme.config.view_templates.map{|t|t[0]}).each &:deactivate!
    end

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
        "
      end
    end

    serialized_attr_accessor :google_analytics, :google_site_verification, :facebook, :twitter, :theme

  end
end
