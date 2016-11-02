class UsernamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :update]

  def new
  end

  def update
    @user.name_changed = true

    if @user.update(user_params)
      redirect_to issues_path, notice: t('notice.updated', model: t('mongoid.models.user'))
    else
      render :new
    end
  end

  private

  def set_user
    @user = current_user
    name_changed?
  end

  def user_params
    params.require(:user).permit(:full_name)
  end

  def name_changed?
    redirect_to issues_path, notice: t('notice.name_chagend') and return if @user.name_changed
  end
end
