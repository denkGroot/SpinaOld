module Spina
  module Admin
    class AccountsController < AdminController

      load_and_authorize_resource class: Account

      layout "spina/admin/settings"

      def edit
        add_breadcrumb "Algemene gegevens", edit_admin_account_path
      end

      def update
        if current_account.update_attributes(params[:account])
          redirect_to :back
        end
      end

      def analytics
        add_breadcrumb "Algemene gegevens", analytics_admin_account_path
      end

      def social
        add_breadcrumb "Social media", social_admin_account_path
      end

      def style
        add_breadcrumb "Stijling", style_admin_account_path
      end
    end
  end    
end
