module Spina
  class ApplicationController < ActionController::Base
    before_filter :default_menu

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    private

    def default_menu
      Menu.new Page.sorted
    end
    helper_method :default_menu
    
    def current_account
      @current_account ||= Account.first
    end
    helper_method :current_account
    
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

  end
end
