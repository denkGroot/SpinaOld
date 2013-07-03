module Spina
  module Admin
    class AccountsController < AdminController

      load_and_authorize_resource class: Account

      def update
        if current_account.update_attributes(params[:account])
          redirect_to :back
        end
      end

      def analytics
      end

      def social
      end
    end
  end    
end
