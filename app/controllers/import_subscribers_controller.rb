class ImportSubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate_and_profiles, only: %i[new create]

  def new
    @subscriber = Subscriber.new
  end

  def create
    begin
      options = {
        certificate: @certificate,
        profile_id: params[:subscriber][:profile_id],
        file: params[:subscriber][:file]
      }
      SpreadSheet.import(**options)
    rescue Exception => e
      redirect_to new_certificate_import_subscriber_path(@certificate),
                  alert: e.message and return
    end

    redirect_to certificate_subscribers_path(params[:certificate_id]),
                notice: t('notice.imported', model: t('title.models.subscribers'))
  end

  private

  def set_certificate_and_profiles
    @certificate = current_user.certificates.find(params[:certificate_id])
    @profiles = Profile.all.by_name
  end
end
