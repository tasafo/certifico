class ApplicationMailer < ActionMailer::Base
  default from: "Certifico <nao-responda@#{ENV['HOST_URL']}>"
  layout 'mailer'
end
