module Spina
  class FrontendController < ApplicationController
    before_filter :default_menu

    private

    def default_menu
      Menu.new Page.sorted
    end
    helper_method :default_menu
    
  end
end