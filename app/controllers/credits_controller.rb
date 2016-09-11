class CreditsController < ApplicationController
  before_action :authenticate_user!

  def index
    @credits = current_user.credits.order(c_at: :asc)
  end

  def new
    @credit = Credit.new
    @credit.price = credit_value
  end

def create
    @credit = current_user.credits.new(credit_params)
    @credit.price = credit_value

    payment = PagSeguro::PaymentRequest.new

    payment.reference = "CC#{@credit.id}"
    payment.notification_url = ENV['PAGSEGURO_NOTIFICATION_URL']
    payment.redirect_url = ENV['PAGSEGURO_REDIRECT_URL']
    payment.abandon_url = ENV['PAGSEGURO_ABANDON_URL']

    payment.items << {
      id: '1',
      description: "certificar.me - compra de creditos",
      quantity: @credit.quantity,
      amount: @credit.price
    }

    payment.extra_params << { senderName: current_user.full_name }
    payment.extra_params << { senderEmail: current_user.email }

    if @credit.valid?
      response = payment.register

      if response.errors.any?
        redirect_to credits_path, notice: response.errors.join('\n')
      else
        @credit.save
        puts response.inspect
        redirect_to response.url
      end
    else
      render :new
    end
  end

  private

  def credit_params
    params.require(:credit).permit(:quantity)
  end

  def credit_value
    price = CreditParameter.last.price

    redirect_to @credits, notice: t('notice.zero_credit') and return if price.nil? || price <= 0

    price
  end
end
