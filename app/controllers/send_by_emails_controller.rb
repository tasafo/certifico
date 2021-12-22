class SendByEmailsController < ApplicationController
  before_action :authenticate_user!

  def create
    certificate = current_user.certificates.find(params[:certificate_id])
    subscriber_id = params[:subscriber_id]

    certificate.queue_emails(subscriber_id, params)

    redirect_to certificate_subscribers_path(certificate),
                notice: t('notice.certificates_sent')
  end
end
