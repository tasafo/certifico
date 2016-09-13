class IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def update
    subscriber = current_user.subscribers.find(params[:id])

    if subscriber
      user_name = current_user.full_name.parameterize
      certificate_title = subscriber.certificate.title.parameterize
      profile_name = subscriber.profile.name.parameterize

      Download.create(user: current_user, certificate: subscriber.certificate)

      send_data GenerateCertificate.new(subscriber).save,
                filename: "certificar-me_#{user_name}_#{certificate_title}_#{profile_name}.pdf",
                type: "application/pdf"
    end
  end
end
