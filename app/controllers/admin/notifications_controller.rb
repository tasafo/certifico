class Admin::NotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    notification_code = params[:notificationCode]

    transaction = PagSeguro::Transaction.find_by_notification_code(notification_code)

    if transaction.errors.empty?
      status_id = transaction.status.id

      credit = Credit.find(transaction.reference[2..-1])

      if credit
        fee_amount = transaction.respond_to?(:operational_fee_amount) ? transaction.operational_fee_amount : 0

        credit.update(
          transaction: transaction.code,
          method: transaction.payment_method.type_id,
          status: status_id,
          fee: fee_amount
        )

        credit.update(paid_at: DateTime.now) if status_id == '3'

        credit.histories.create(status: status_id, notification: notification_code)
      end
    end

    render nothing: true, status: 200
  end
end
