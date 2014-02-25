module Spina
  module Admin
    class AdminController < ApplicationController
      
      before_filter :authorize_user
      before_filter :new_messages

      layout 'spina/admin/application'

      private

      def authorize_user
        redirect_to spina.admin_login_url, flash: {information: "Je zult eerst moeten inloggen."} unless current_user
      end

      def new_messages
        @new_messages = Inquiry.new_messages.sorted
      end

      def current_account
        @current_account ||= Account.first
      end
      helper_method :current_account
      
      def current_user
        @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
      end
      helper_method :current_user

      def current_ability
        @current_ability ||= Ability.new(current_user)
      end

    end
  end
end