class IssuesController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show
    subscriber = current_user.subscribers.find(params[:id])

    if subscriber
      user_name = current_user.full_name.parameterize
      certificate_title = subscriber.certificate.title.parameterize
      profile_name = subscriber.profile.name.parameterize

      send_data GenerateCertificate.new(subscriber).save,
                filename: "certificar-me_#{user_name}_#{certificate_title}_#{profile_name}.pdf",
                type: "application/pdf"
    else
      redirect_to issues_path, notice: t('notice.not_found', model: t('title.issue'))
    end
  end
end
