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

    if @credit.valid?
      @credit.save
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
