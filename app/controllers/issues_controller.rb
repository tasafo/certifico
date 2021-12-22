class IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
    session[:back_to] = issues_path

    @subscribers = current_user.subscribers.with_relations
                               .page(params[:page]).per(10)
  end

  def update
    subscriber = current_user.subscribers.find(params[:id])
    subscriber.downloads.create

    download_certificate(subscriber, subscriber.certificate_file_name)
  end

  def destroy
    subscriber = Subscriber.find(params[:id])

    download_certificate(subscriber, subscriber.certificate_file_name)
  end

  private

  def download_certificate(subscriber, file_name)
    send_data subscriber.generate_certificate.save,
              filename: file_name, type: 'application/pdf'
  end
end
