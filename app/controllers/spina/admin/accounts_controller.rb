module Spina
  class Admin::AccountsController < Admin::ApplicationController
    load_and_authorize_resource class: Spina::Account

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
