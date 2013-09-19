module Spina
  class Theme

    attr_accessor :name, :config

    def to_s
      name
    end

    def register
      ::Spina::ThemeCollection.registered << self
    end
  end
end
