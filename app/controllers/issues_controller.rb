class IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscribers = current_user.subscribers.with_relations.page(params[:page]).per(10)
  end

  def update
    generate(current_user.subscribers.find(params[:id]), true)
  end

  def destroy
    generate(Subscriber.find(params[:id]), false)
  end

  private

  def generate(subscriber, register_download)
    return unless subscriber

    user_name = subscriber.user.full_name.parameterize
    certificate_title = subscriber.certificate.title.parameterize
    profile_name = subscriber.profile.name.parameterize

    Download.create(subscriber: subscriber) if register_download

    send_data GenerateCertificate.new(subscriber).save,
              filename: "certifico_#{user_name}_#{certificate_title}_#{profile_name}.pdf",
              type: "application/pdf"
  end
end
