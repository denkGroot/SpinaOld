require_dependency "spina/application_controller"

module Spina
  class SessionsController < ApplicationController
    layout "spina/login"

    skip_before_filter :authorize_user

    def new
    end

    def create
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_url
      else
        flash.now.alert = "Email of wachtwoord is onjuist"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_url
    end
  end
end
