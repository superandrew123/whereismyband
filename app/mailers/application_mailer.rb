class ApplicationMailer < ActionMailer::Base
  default from: ENV["gmail"]
  layout 'mailer'
end
