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
      end
      if @inquiry.save
        @inquiry.spam! unless @captcha.valid?           
        InquiryMailer.inquiry(@inquiry).deliver unless @inquiry.spam
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