class SendByEmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: [:create]

  def create
    subscribers = Subscriber.search(params, @certificate)[:records]

    subscribers.each do |subscriber|
      CertificateMailer.with(subscriber_id: subscriber.id.to_s)
                       .with_attachment.deliver_later
    end

    redirect_to certificate_subscribers_path(@certificate),
                notice: t('notice.certificates_sent')
  end

  private

  def set_certificate
    @certificate = current_user.certificates.find(params[:certificate_id])
  end
end
