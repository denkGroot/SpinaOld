module Spina
  class Plugin
    attr_accessor :name, :class_name, :controller, :pictos_icon, :path

    def to_s
      name
    end
  end
end
