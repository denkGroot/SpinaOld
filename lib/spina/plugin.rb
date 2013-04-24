module Spina
  class Plugin
    attr_accessor :name, :class_name, :controller, :pictos_icon

    def to_s
      name
    end
  end
end
