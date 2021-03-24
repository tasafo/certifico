class SendByEmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: [:create]

  def create
    subscriber_id = params[:subscriber_id]

    if subscriber_id
      Certificate.send_by_email(subscriber_id)
    else
      subscribers = Subscriber.search(params, @certificate)[:records]

      subscribers.each do |subscriber|
        Certificate.send_by_email(subscriber.id.to_s)
      end
    end

    redirect_to certificate_subscribers_path(@certificate),
                notice: t('notice.certificates_sent')
  end

  private

  def set_certificate
    @certificate = current_user.certificates.find(params[:certificate_id])
  end
end
