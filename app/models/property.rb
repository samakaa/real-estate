class Property < ApplicationRecord
  belongs_to :agent, class_name: 'User'
  has_many_attached :images , dependent: :destroy
  has_many_attached :attachments


  validate :acceptable_image
  TYPES = ['Apartment', 'Villa', 'Studio', 'House', 'Office'].freeze

  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(created_at: :desc) }
   def self.ransackable_attributes(auth_object = nil)
    [
      "title", "description", "price", "bedrooms", "bathrooms", "agent_id", 
      "property_type", "address", "label", "zip_code", "country", "province_state", 
      "neighborhood", "unit_price", "status", "size", "land_area", "year_built", 
      "latitude", "longitude", "rooms", "garages", "created_at", "updated_at"
    ]
  end

    # Define searchable associations
  def self.ransackable_associations(auth_object = nil)
    ["agent"] # Replace with other associations as needed
  end
 def geocode
    results = Geocoder.search(self.address)
    if results.present?
      self.latitude = results.first.coordinates[0]
      self.longitude = results.first.coordinates[1]
    else
      Rails.logger.warn("Geocoding failed for address: #{self.address}")
      errors.add(:address, "could not be geocoded. Please provide a valid address.")
    end
  end
  private

  def acceptable_image
    images.each do |image|
      unless image.blob.byte_size <= 5.megabytes
        errors.add(:images, "Each image must be smaller than 5MB")
      end
    end
  end
  
end
