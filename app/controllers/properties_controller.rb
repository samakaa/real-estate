class PropertiesController < ApplicationController
  before_action :authenticate_user! , only: %i[ edit update destroy index]
  before_action :ensure_agent_user, only: [:new, :create]
  before_action :set_property, only: %i[show edit update destroy]
  before_action :require_same_user, only: [:edit, :update]
  require 'net/http'
  require 'json'
  require 'haversine'

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
    
    @properties = Property.where(agent_id: current_user.id)
    
  end

 def show
   @properties = Property.featured.recent.limit(10) # Adjust scope as needed
  @property = Property.find(params[:id])
  
    @locations = [
      {
        title: @property.title,
        latitude: @property.latitude,
        longitude: @property.longitude,
        address: @property.address
      }
    ]
     @location = [
    { name: 'Patsry Sfar', latitude: 35.509896628753374, longitude: 11.051859751676746 },
    { name: 'University', latitude: 35.52258770822307, longitude: 11.03038695099358 },
    { name: 'Dar Shat', latitude: 35.52751358395876, longitude: 11.037824782331114 },
    { name: 'Carrefour Market', latitude: 35.50703238075593, longitude: 11.052217653667519 },
    { name: 'Hospital', latitude: 35.510703409354676, longitude: 11.032397645726537 },
    { name: 'Central Metro station', latitude: 35.50076115195508, longitude: 11.064438140721364 },
    { name: 'Clinic Exellence', latitude: 35.4995412153538, longitude: 11.05860916252987 },
    { name: 'Night pharmacy Zone', latitude: 35.526120227787615, longitude: 11.032771503442492 }, 
  ]

  # Calculate distances using Haversine formula
  @nearby_locations = @location.map do |location|
    distance = Haversine.distance(
      @property.latitude, @property.longitude,
      location[:latitude], location[:longitude]
    ).to_km
    location.merge(distance: distance.round(1)) # Add distance in km
  end
 #   api_key = "valid api"
 # radius = 2000 # Search radius in meters

  # Base URL for Google Places API
 # url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@property.latitude},##{@property.longitude}&radius=#{radius}&key=#{api_key}")

 # response = Net::HTTP.get(url)
 # places = JSON.parse(response)["results"]

 # @nearby_locations = places.map do |place|
  #  {
  #    name: place["name"],
 #     type: place["types"].first.capitalize,
 #     distance: "Within #{radius / 1000} km"
 #   }
#  end
end

  def edit
     @property
  end

def update
  if params[:property][:images_to_delete].present?
    params[:property][:images_to_delete].each do |image_id|
      image = @property.images.find(image_id)
      image.purge
    end
  end

  # Append new images if any are uploaded
  if params[:property][:images].present?
    @property.images.attach(params[:property][:images])
  end

  if @property.update(property_params.except(:images))
    redirect_to @property, notice: 'Property was successfully updated.'
  else
    render :edit, status: :unprocessable_entity
  end
end





def destroy
  @property = current_user.properties.find(params[:id])
  @property.destroy
  respond_to do |format|
    format.html { redirect_to properties_path, notice: "Property successfully deleted." }
    format.turbo_stream # For Turbo dynamic updates
  end
end

  private
     def require_same_user

          if current_user.id != @property.agent_id

               flash[:danger] = "Vous n'avez pas le droit de modifier cette page"

               redirect_to root_path

          end
        end
  def set_property
    @property = Property.find(params[:id])
  end

  def ensure_agent_user
    redirect_to root_path, alert: 'Only agents can create properties' unless current_user.agent?
  end

  def property_params
  params.require(:property).permit(
    :title, :description, :price, :bedrooms, :bathrooms, :agent_id, :property_type, :address, :video, :label,
    :zip_code, :country, :province_state, :neighborhood, :unit_price, :status, :size, :land_area, :year_built,
    :latitude, :longitude, :rooms, :garages, amenities: [], attachments: [], images: []
  )
end

end
