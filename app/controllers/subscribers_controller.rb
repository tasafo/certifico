class SubscribersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate_and_profiles, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_subscriber, only: [:edit, :update, :destroy]
  before_action :authorization, only: [:edit]

  def index
  end

  def new
    check_credits certificate_path(@certificate)
    @subscriber = Subscriber.new
    @subscriber.user = User.new
  end

  def edit
  end

  def create
    check_credits certificate_path(@certificate)
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.certificate = @certificate
    @subscriber.user.password = rand(11111111..99999999)

    user = User.find_by(email: @subscriber.user.email)
    @subscriber.user = user if user

    if @subscriber.user.save && @subscriber.save
      redirect_to certificate_subscribers_path(@certificate),
        notice: t('notice.created', model: t('mongoid.models.subscriber'))
    else
      render :new
    end
  end

  def update
    if @subscriber.update(subscriber_params)
      redirect_to certificate_subscribers_path(@certificate),
        notice: t('notice.updated', model: t('mongoid.models.subscriber'))
    else
      message = @subscriber.errors.messages[:user_id][0]

      if message
        redirect_to edit_certificate_subscriber_path(@certificate, @subscriber),
          alert: "#{t('mongoid.models.profile')} #{message}"
      else
        set_subscriber

        render :edit
      end
    end
  end

  def destroy
    begin
      @subscriber.destroy

      notice = t('notice.destroyed', model: t('mongoid.models.subscriber'))
    rescue Mongoid::Errors::DeleteRestriction
      notice = t('notice.delete.restriction.subscriber')
    end

    redirect_to certificate_subscribers_path(@certificate), notice: notice
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(
      :profile_id,
      :theme,
      user_attributes: [:email, :full_name, :user_name]
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
    redirect_to certificate_path(@certificate),
      notice: t('notice.not_found', model: t('mongoid.models.subscriber')) and return if @subscriber.nil?
  end
end
