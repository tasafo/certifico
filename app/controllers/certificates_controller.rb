class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certificate, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[new create edit update]
  before_action :authorization, only: %i[show edit]

  def index
    query = current_user.certificates.with_relations
    @pagy, @records = pagy(query, count: query.count)
  end

  def show; end

  def new
    @certificate = Certificate.new
  end

  def edit; end

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
    @certificate.destroy_image if certificate_params[:image] || certificate_params[:remove_image] == '1'

    if @certificate.update(certificate_params)
      redirect_to @certificate, notice: t('notice.updated', model: t('mongoid.models.certificate'))
    else
      render :edit
    end
  end

  def destroy
    @certificate.destroy_image
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
      :site, :image, :image_cache, :remove_image, :template_id, :category_id
    )
  end

  def authorization
    return if @certificate

    redirect_to certificates_path,
                notice: t('notice.not_found', model: t('mongoid.models.certificate')) and return
  end
end
