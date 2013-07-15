module Spina
  class Menu
    def initialize(objects = nil)
       append(objects)
    end

    def append(objects)
      Array(objects).each do |object|
        item = object.to_menu_item if object.respond_to?(:to_menu_item)
        items << MenuItem.new(self, item)
      end
    end

    attr_accessor :items

    def items
      @items ||= []
    end

    def roots
      @roots ||= select {|item| item.orphan? && item.depth == minimum_depth }
    end

    def to_s
      map(&:title).join(' ')
    end

    delegate :inspect, :map, :select, :detect, :first, :last, :length, :size, :to => :items

    protected
    def minimum_depth
      map(&:depth).min
    end


  end
end