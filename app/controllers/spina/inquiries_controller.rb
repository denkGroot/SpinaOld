require_dependency "spina/frontend_controller"

module Spina
  class InquiriesController < FrontendController

    before_filter :setup_negative_captcha, :only => [:new, :create]
    before_filter :set_page


    def new
      @inquiry = Inquiry.new
    end

    def create
      if @captcha.valid?
        @inquiry = Inquiry.new(@captcha.values)
      else
        @inquiry = Inquiry.new
        @inquiry.name = params[:name]
        @inquiry.email = params[:email]
        @inquiry.message = params[:message]
        @inquiry.phone = params[:phone]
      end
      if @inquiry.save
        @inquiry.spam! unless @captcha.valid?
        render :create
      else
        flash[:notice] = @captcha.error if @captcha.error 
        render :failed
      end
    end



    private

    def set_page
      @page = Page.find_by_title 'Contact'
    end

    def setup_negative_captcha
      @captcha = NegativeCaptcha.new(
        secret: Spina::Engine.config.NEGATIVE_CAPTCHA_SECRET,
        spinner: request.remote_ip,
        fields: [:email, :message, :name],
        params: params
      )
    end

  end
end