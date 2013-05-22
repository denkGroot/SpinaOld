module Spina
  class InquiryMailer < ActionMailer::Base
    default from: Account.first.email || "info@denkgroot.com"

    layout 'spina/email'

    helper Spina::ApplicationHelper

    def inquiry(inquiry)
      @inquiry = inquiry
      current_account = Account.first

      attachments.inline['logo.jpg'] = File.read(current_account.logo.path) if current_account.logo.path

      mail( 
        to: "\"#{current_account.name}\" <#{ current_account.email }>", 
        from: "\"#{@inquiry.name}\" <#{@inquiry.email}>", 
        subject: @inquiry.message.truncate(97, separator: ' ')
      )
    end

  end
end
