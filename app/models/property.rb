class Property < ApplicationRecord
  belongs_to :agent, class_name: 'User'
  has_many_attached :images
  has_many_attached :attachments


  validate :acceptable_image
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
