class Admin::ValidatesController < ApplicationController
  def show
    @subscriber = Subscriber.find(params[:id])

    unless @subscriber
      redirect_to root_path,
        notice: t('notice.not_found', model: t('mongoid.models.certificate'))
    end
  end
end
