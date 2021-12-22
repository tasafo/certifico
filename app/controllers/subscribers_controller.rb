class SubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate_and_profiles, only: %i[index new edit create update destroy]
  before_action :set_subscriber, only: %i[edit update destroy]
  before_action :authorization, only: %i[edit]

  def index
    session[:back_to] = certificate_subscribers_path(@certificate)

    subscribers = Subscriber.search(params, @certificate)

    @subscribers = Kaminari.paginate_array(subscribers[:records])
                           .page(params[:page]).per(20)

    @subscribers_count = subscribers[:count]
  end

  def new
    @subscriber = Subscriber.new

    @subscriber.user = User.new
  end

  def edit; end

  def create
    @subscriber = @certificate.subscribers.new(subscriber_params)

    if @subscriber.save
      redirect_to certificate_subscribers_path(@certificate),
                  notice: t('notice.created', model: t('mongoid.models.subscriber'))
    else
      render :new
    end
  end

  def update
    if @subscriber.update(subscriber_params)
      redirect_to certificate_subscribers_path(@certificate),
                  notice: t('notice.updated', model: t('mongoid.models.subscriber')) and return
    end

    message = @subscriber.errors.messages[:user_id][0]

    if message
      redirect_to edit_certificate_subscriber_path(@certificate, @subscriber),
                  alert: "#{t('mongoid.models.profile')} #{message}"
    else
      set_subscriber
      render :edit
    end
  end

  def destroy
    @subscriber.destroy

    if @subscriber.errors.blank?
      redirect_to certificate_subscribers_path(@certificate),
                  notice: t('notice.destroyed', model: t('mongoid.models.subscriber'))
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(
      :profile_id, :theme,
      user_attributes: %i[email full_name user_name]
    )
  end

  def set_certificate_and_profiles
    @certificate = current_user.certificates.find(params[:certificate_id])

    @profiles = Profile.all.by_name
  end

  def set_subscriber
    @subscriber = @certificate.subscribers.find(params[:id])
  end

  def authorization
    unless @subscriber
      redirect_to certificate_path(@certificate),
                  notice: t('notice.not_found', model: t('mongoid.models.subscriber')) and return
    end
  end
end
