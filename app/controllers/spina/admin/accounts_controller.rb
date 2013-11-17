module Spina
  module Admin
    class AccountsController < AdminController

      authorize_resource class: Account

      layout "spina/admin/settings"

      def edit
        add_breadcrumb "Algemene gegevens", spina.edit_admin_account_path
      end

      def update
        if current_account.update_attributes(account_params)
          redirect_to :back, notice: "Voorkeuren zijn bijgewerkt"
        end
      end

      def analytics
        add_breadcrumb "Google Analytics", spina.analytics_admin_account_path
      end

      def social
        add_breadcrumb "Social media", spina.social_admin_account_path
      end

      def style
        add_breadcrumb "Stijl", spina.style_admin_account_path
      end

      private

      def account_params
        params.require(:account).permit(:address, :city, :email, :logo, :name, :phone, :postal_code, :preferences, :google_analytics, :google_site_verification, :facebook, :twitter)
      end
    end
  end    
end
