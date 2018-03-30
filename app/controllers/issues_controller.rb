class IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscribers = current_user.subscribers.with_relations.page(params[:page]).per(10)
  end

  def update
    subscriber = current_user.subscribers.find(params[:id])

    if subscriber
      user_name = current_user.full_name.parameterize
      certificate_title = subscriber.certificate.title.parameterize
      profile_name = subscriber.profile.name.parameterize

      Download.create(subscriber: subscriber)

      send_data GenerateCertificate.new(subscriber).save,
                filename: "certifico_#{user_name}_#{certificate_title}_#{profile_name}.pdf",
                type: "application/pdf" and return
    end
  end
end
