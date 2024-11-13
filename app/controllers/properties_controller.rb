class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_agent_user, only: [:new, :create]
  before_action :set_property, only: %i[show edit update destroy]

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.agent_id = current_user.id

    if @property.save
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @properties = Property.all
  end

 def show
  @property = Property.find(params[:id])
end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_url, notice: 'Property was successfully destroyed.'
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def ensure_agent_user
    redirect_to root_path, alert: 'Only agents can create properties' unless current_user.agent?
  end

  def property_params
    params.require(:property).permit(
      :title, :description, :price, :bedrooms, :bathrooms, :agent_id,
      :zip_code, :country, :province_state, :neighborhood, :unit_price, :status, :size, :land_area, :year_built,
      :rooms, :garages, amenities: [], attachments: [], images: []
    )
  end
end
