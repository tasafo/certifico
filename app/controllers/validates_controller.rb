class ValidatesController < ApplicationController
  def new
    @subscriber = Subscriber.new
    @subscriber.id = nil
  end

  def create
    @subscriber = Subscriber.find(params[:subscriber][:id])

    if @subscriber
      redirect_to validate_path(@subscriber.id)
    else
      redirect_to new_validate_path,
                  notice: t('notice.not_found', model: t('mongoid.models.certificate'))
    end
  end

  def show
    @subscriber = Subscriber.find(params[:id])

    unless @subscriber
      redirect_to root_path,
                  notice: t('notice.not_found', model: t('mongoid.models.certificate'))
    end
  end
end
