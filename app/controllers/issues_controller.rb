class IssuesController < ApplicationController
  def index

  end

  def show
    subscriber = Subscriber.find(params[:id])
    user_name = current_user.name.parameterize
    certificate_title = subscriber.certificate.title.parameterize
    profile_name = subscriber.profile.name.parameterize

    send_data GenerateCertificate.new(subscriber).save,
              filename: "certificar-me_#{user_name}_#{certificate_title}_#{profile_name}.pdf",
              type: "application/pdf"
  end
end
