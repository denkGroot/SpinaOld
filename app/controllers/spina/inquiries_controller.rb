module Spina
  class InquiriesController < ApplicationController

    before_filter :setup_negative_captcha, :only => [:index, :create]
    before_filter :set_page


    def index
      @inquiry = Inquiry.new
    end

    def create
      @inquiry = Inquiry.new(@captcha.values)
      @inquiry.attributes = params[:invoice_inquiry]
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
      @page = Page.find_by_name 'inquiries'
    end

    def setup_negative_captcha
      @captcha = NegativeCaptcha.new(
        secret: Engine.config.NEGATIVE_CAPTCHA_SECRET,
        spinner: request.remote_ip,
        fields: [:email, :message, :name],
        params: params
      )
    end

  end
end