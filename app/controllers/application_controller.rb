class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_credits(path)
    redirect_to path, notice: t('notice.insufficient_credits') and return if current_user.current_credits <= 0
  end
end
