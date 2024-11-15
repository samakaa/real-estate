module ApplicationHelper
  def youtube_thumbnail_url(video_url)
    video_id = video_url.split("=").last
    "https://img.youtube.com/vi/#{video_id}/maxresdefault.jpg"
  end

    def amenity_icon(amenity)
    case amenity.downcase
    when "first aid kit"
      "fas fa-first-aid"
    when "security cameras"
      "fas fa-video"
    when "tv with standard cable"
      "fas fa-tv"
    when "hangers"
      "fas fa-tshirt"
    when "bed linens"
      "fas fa-bed"
    when "dishwasher"
      "fas fa-water" # Substitute for dishwasher
    when "refrigerator"
      "fas fa-snowflake" # Substitute for refrigerator
    when "microwave"
      "fas fa-burn" # Substitute for microwave
    else
      "fas fa-question-circle" # Fallback icon for unrecognized amenities
    end
  end
end
