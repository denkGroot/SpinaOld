module Spina
  class ApplicationController < ActionController::Base
    include ApplicationHelper

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    private

    def current_account
      @current_account ||= Account.first
    end
    helper_method :current_account
  end
end
