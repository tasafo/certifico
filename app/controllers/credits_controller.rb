class CreditsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_credit, only: [:show]
  before_action :authorization, only: [:show]

  def index
    @credits = current_user.credits.order(c_at: :asc)
  end

  def show
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
    payment.redirect_url = "#{ENV['RETURN_URL']}/credits"
    payment.abandon_url = "#{ENV['RETURN_URL']}/credits"

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
        @credit.histories.create(status: '1')

        redirect_to Rails.env.production? ? response.url : credits_path
      end
    else
      render :new
    end
  end

  private

  def credit_params
    params.require(:credit).permit(:quantity)
  end

  def set_credit
    @credit = current_user.credits.find(params[:id])
  end

  def authorization
    redirect_to credits_path,
      notice: t('notice.not_found', model: t('mongoid.models.credit')) and return if @credit.nil?
  end

  def credit_value
    credit_param = CreditParameter.last

    price = credit_param ? credit_param.price : nil

    redirect_to @credits, notice: t('notice.zero_credit') and return if price.nil? || price <= 0

    price
  end
end
