class ApplicationMailer < ActionMailer::Base
  default from: 'naoresponder@slack.com'
  layout 'mailer'
end
