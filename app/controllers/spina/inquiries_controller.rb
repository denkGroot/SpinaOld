require_dependency "spina/frontend_controller"

module Spina
  class InquiriesController < FrontendController

    def create
      @inquiry = Inquiry.new(params[:inquiry])
      if @inquiry.save
        render :create
      else
        render :failed
      end
    end

  end
end