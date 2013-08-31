module Spina
  module Admin
    class UsersController < AdminController
      
      load_and_authorize_resource class: User

      layout "spina/admin/users"

      add_breadcrumb "Gebruikers", :admin_users_path

      def index
        @users = User.all
      end

      def new
        add_breadcrumb "Nieuwe gebruiker"
      end

      def create
        if @user.save
          redirect_to admin_users_url, notice: "Gebruiker #{@user} is aangemaakt."
        else
          flash[:alert] = "De gebruiker kan nog niet opgeslagen worden."
          render :new
        end
      end

      def edit
        add_breadcrumb "#{@user}"
      end

      def update
        if @user.update_attributes(params[:user])
          redirect_to admin_users_url
        else
          render :edit
        end
      end

      def destroy
        @user.destroy unless @user == current_user
        redirect_to admin_users_url, notice: "De gebruiker is verwijderd."
      end
      
    end
  end
end
