class Property < ApplicationRecord
  belongs_to :agent, class_name: 'User'
  has_many_attached :images
  has_many_attached :attachments



  validate :acceptable_image

  private

  def acceptable_image
    images.each do |image|
      unless image.blob.byte_size <= 5.megabytes
        errors.add(:images, "Each image must be smaller than 5MB")
      end
    end
  end
end
