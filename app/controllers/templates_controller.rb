class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: %i[show edit update destroy]
  before_action :authorization, only: %i[show edit]

  def index
    @templates = current_user.templates.page(params[:page]).per(10)
  end

  def show; end

  def new
    @template = Template.new
  end

  def edit; end

  def create
    @template = Template.new(template_params)
    @template.user = current_user

    if @template.save
      redirect_to @template, notice: t('notice.created', model: t('mongoid.models.template'))
    else
      render :new
    end
  end

  def update
    @template.destroy_image if template_params[:image] || template_params[:remove_image] == '1'

    if @template.update(template_params)
      redirect_to @template, notice: t('notice.updated', model: t('mongoid.models.template'))
    else
      render :edit
    end
  end

  def destroy
    @template.destroy_image
    @template.destroy

    if @template.errors.blank?
      redirect_to templates_path,
                  notice: t('notice.destroyed', model: t('mongoid.models.template'))
    else
      redirect_to template_path(@template),
                  notice: t('notice.delete.restriction.templates')
    end
  end

  private

  def set_template
    @template = current_user.templates.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:name, :font_color, :image,
                                     :image_cache, :remove_image)
  end

  def authorization
    unless @template
      redirect_to templates_path,
                  notice: t('notice.not_found', model: t('mongoid.models.template')) and return
    end
  end
end
