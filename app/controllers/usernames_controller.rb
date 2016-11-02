class UsernamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    name_changed?
  end

  def update
    @user = User.find(params[:id])
    name_changed?
    @user.name_changed = true

    if @user.update(user_params)
      redirect_to issues_path, notice: t('notice.updated', model: t('mongoid.models.user'))
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name)
  end

  def name_changed?
    redirect_to issues_path, notice: t('notice.name_chagend') and return if @user.name_changed
  end
end
