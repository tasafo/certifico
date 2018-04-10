class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Mongoid::Errors::DeleteRestriction, with: :delete_restriction

  private

  def delete_restriction
    path = controller_name == 'registrations' ? '/users/edit' : "/#{controller_name}"

    redirect_to path, notice: t("notice.delete.restriction.#{controller_name}")
  end
end
