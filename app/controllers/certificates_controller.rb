class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: [:show, :edit, :update, :destroy]
  before_action :authorization, only: [:show, :edit]

  def index
    @certificates = current_user.certificates
  end

  def show
  end

  def new
    @certificate = Certificate.new
  end

  def edit
  end

  def create
    @certificate = Certificate.new(certificate_params)
    @certificate.user = current_user

    if @certificate.save
      redirect_to @certificate, notice: t('notice.created', model: t('mongoid.models.certificate'))
    else
      render :new
    end
  end

  def update
    if @certificate.update(certificate_params)
      redirect_to @certificate, notice: t('notice.updated', model: t('mongoid.models.certificate'))
    else
      render :edit
    end
  end

  def destroy
    begin
      @certificate.destroy

      notice = t('notice.destroyed', model: t('mongoid.models.certificate'))
    rescue Mongoid::Errors::DeleteRestriction
      notice = t('notice.delete.restriction.certificate')
    end

    redirect_to certificates_path, notice: notice
  end

  private

  def set_certificate
    @certificate = current_user.certificates.find(params[:id])
  end

  def certificate_params
    params.require(:certificate).permit(
      :title,
      :initial_date,
      :final_date,
      :workload,
      :local,
      :site,
      :image,
      :template_id,
      :category_id
    )
  end

  def authorization
    redirect_to certificates_path,
      notice: t('notice.not_found', model: t('mongoid.models.certificate')) and return if @certificate.nil?
  end
end
