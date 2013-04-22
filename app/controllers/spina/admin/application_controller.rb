require_dependency "spina/application_controller"

module Spina
  class Admin::ApplicationController < ApplicationController
    
    before_filter :authorize_user
    before_filter :new_messages
    
    layout "layouts/spina/admin"

    private

    def authorize_user
      redirect_to admin_login_url, flash: {information: "Je zult eerst moeten inloggen."} unless current_user
    end

    def new_messages
      @new_messages = Inquiry.new_messages.sorted
    end

  end
end