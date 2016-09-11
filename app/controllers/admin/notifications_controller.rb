class Admin::NotificationsController < ApplicationController
  def create
    transaction = PagSeguro::Transaction.find_by_notification_code(params[:notificationCode])

    if transaction.errors.empty?
      puts "=" * 30
      puts transaction.inspect
      puts "=" * 30
    end

    render nothing: true, status: 200
  end
end
