require_dependency "spina/frontend_controller"

module Spina
  class InquiriesController < FrontendController

    before_filter :setup_negative_captcha, :only => [:index, :create]
    before_filter :set_page


    def index
      @inquiry = Inquiry.new
    end

    def create
      if @captcha.valid?
        @inquiry = Inquiry.new(@captcha.values)
        @inquiry.attributes = params[:invoice_inquiry]
      else
        @inquiry = Inquiry.new
        @inquiry.name = params[:name]
        @inquiry.email = params[:email]
        @inquiry.message = params[:message]
        @inquiry.phone = params[:phone]
        @inquiry.attributes = params[:invoice_inquiry]
        @inquiry.archived = true
      end
      if @inquiry.save && @captcha.valid?
        InquiryMailer.inquiry(@inquiry).deliver
        render :create
      else
        @inquiry.spam!
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