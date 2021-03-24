class ApplicationMailer < ActionMailer::Base
  default from: "nao-responda@#{ENV['HOST_URL']}"
  layout 'mailer'
end
