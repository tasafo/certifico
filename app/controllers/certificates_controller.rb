class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  before_action :authorization, only: [:show, :edit]

  def index
    @certificates = current_user.certificates.with_relations.page(params[:page]).per(10)
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
    @certificate.destroy

    if @certificate.errors.blank?
      redirect_to certificates_path,
        notice: t('notice.destroyed', model: t('mongoid.models.certificate'))
    else
      redirect_to certificate_path(@certificate),
        notice: t('notice.delete.restriction.certificates')
    end
  end

  private

  def set_certificate
    @certificate = current_user.certificates.find(params[:id])
  end

  def set_categories
    @categories = Category.all.by_name
  end

  def certificate_params
    params.require(:certificate).permit(
      :title, :initial_date, :final_date, :workload, :local,
      :site, :image, :remove_image, :template_id, :category_id
    )
  end

  def authorization
    redirect_to certificates_path,
      notice: t('notice.not_found', model: t('mongoid.models.certificate')) and return if @certificate.nil?
  end
end
