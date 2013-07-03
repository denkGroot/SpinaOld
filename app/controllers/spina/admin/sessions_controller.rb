module Spina
  module Admin
    class SessionsController < AdminController
      
      layout "spina/login"

      skip_before_filter :authorize_user

      def new
      end

      def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          user.update_last_logged_in!
          redirect_to admin_root_url
        else
          flash.now.alert = "Email of wachtwoord is onjuist"
          render "new"
        end
      end

      def destroy
        session[:user_id] = nil
        redirect_to "/"
      end
    end  
  end
end
