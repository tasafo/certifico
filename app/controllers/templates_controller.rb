class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  before_action :authorization, only: [:show, :edit]

  def index
    @templates = current_user.templates
  end

  def show
  end

  def new
    @template = Template.new
  end

  def edit
  end

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
    if @template.update(template_params)
      redirect_to @template, notice: t('notice.updated', model: t('mongoid.models.template'))
    else
      render :edit
    end
  end

  def destroy
    begin
      @template.destroy

      notice = t('notice.destroyed', model: t('mongoid.models.template'))
    rescue Mongoid::Errors::DeleteRestriction
      notice = t('notice.delete.restriction.template')
    end

    redirect_to templates_path, notice: notice
  end

  private

  def set_template
    @template = current_user.templates.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:name, :font_color, :image)
  end

  def authorization
    redirect_to templates_path and return if @template.nil?
  end
end
