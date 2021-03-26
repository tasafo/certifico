class UsernamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    @user.name_changed = true

    if @user.update(user_params)
      redirect_to params[:back_to], notice: t('notice.updated', model: t('mongoid.models.user'))
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    @back_to = params[:back_to].to_s
    @subscriber_id = params[:subscriber_id]

    name_changed?
    permission?
  end

  def user_params
    params.require(:user).permit(:full_name)
  end

  def name_changed?
    redirect_to params[:back_to], alert: t('notice.name_chaged') and return if @user.name_changed
  end

  def permission?
    allowed = false

    if @back_to.include?('issue')
      allowed = current_user == @user

    elsif @back_to.include?('subscriber') && @subscriber_id
      subscriber = Subscriber.find(@subscriber_id)

      allowed = current_user == subscriber.certificate.user
    end

    redirect_to @back_to, alert: t('notice.unauthorized') and return unless allowed
  end
end
