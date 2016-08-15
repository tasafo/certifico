class SubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate_and_profiles, only: [:new, :edit, :create, :update]
  before_action :set_subscriber, only: [:edit, :update]
  before_action :authorization, only: [:edit]

  def new
    @subscriber = Subscriber.new
    @subscriber.user = User.new
  end

  def edit
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.certificate = @certificate
    @subscriber.user.password = rand(11111111..99999999)

    if @subscriber.user.save && @subscriber.save
      redirect_to certificate_path(@certificate), notice: t('notice.created', model: t('mongoid.models.subscriber'))
    else
      render :new
    end
  end

  def update
    if @subscriber.update(subscriber_params)
      redirect_to certificate_path(@certificate), notice: t('notice.updated', model: t('mongoid.models.subscriber'))
    else
      render :edit
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:profile_id, :theme, user_attributes: [:email, :name])
  end

  def set_certificate_and_profiles
    @certificate = current_user.certificates.find(params[:certificate_id])
    @profiles = Profile.all.by_name
  end

  def set_subscriber
    @subscriber = @certificate.subscribers.find(params[:id])
  end

  def authorization
    redirect_to certificates_path and return if @subscriber.nil?
  end
end
