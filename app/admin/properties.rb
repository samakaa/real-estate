ActiveAdmin.register Property do
  # Permitted parameters (strong parameters)
  permit_params :title, :description, :price, :bedrooms, :bathrooms, :agent_id, :property_type, 
                :address, :video, :label, :zip_code, :country, :province_state, :neighborhood,
                :unit_price, :status, :size, :land_area, :year_built, :latitude, :longitude, 
                :rooms, :garages, amenities: [], attachments: [], images: []

  # Index page: Customize columns displayed
  index do
    selectable_column
    id_column
    column :title
    column :price do |property|
      number_to_currency(property.price)
    end
    column :bedrooms
    column :bathrooms
    column :status
    column :agent_id
    column :created_at
    actions
  end

  # Filters in the sidebar
  filter :title
  filter :price
  filter :bedrooms
  filter :bathrooms
  filter :status
  filter :country
  filter :province_state
  filter :created_at

  # Show page: Customize what is displayed
  show do
    attributes_table do
      row :title
      row :description
      row :price do |property|
        number_to_currency(property.price)
      end
      row :bedrooms
      row :bathrooms
      row :agent_id
      row :property_type
      row :address
      row :zip_code
      row :country
      row :province_state
      row :neighborhood
      row :unit_price
      row :status
      row :size
      row :land_area
      row :year_built
      row :latitude
      row :longitude
      row :rooms
      row :garages
      row :amenities do |property|
        property.amenities.join(', ')
      end
      row :attachments do |property|
        property.attachments.each do |attachment|
          link_to attachment.filename.to_s, rails_blob_path(attachment, disposition: "attachment")
        end
      end
      row :images do |property|
        property.images.each do |image|
          image_tag rails_blob_path(image, only_path: true), width: "100"
        end
      end
    end
  end

  # Form for creating/editing properties
  form do |f|
    f.inputs "Property Details" do
      f.input :title
      f.input :description
      f.input :price
      f.input :bedrooms
      f.input :bathrooms
      f.input :agent_id, as: :select, collection: Agent.all.map { |a| [a.name, a.id] } # Assuming Agent is a model
      f.input :property_type, as: :select, collection: ["House", "Apartment", "Condo"] # Example options
      f.input :address
      f.input :zip_code
      f.input :country
      f.input :province_state
      f.input :neighborhood
      f.input :unit_price
      f.input :status, as: :select, collection: ["Available", "Sold", "Pending"]
      f.input :size
      f.input :land_area
      f.input :year_built
      f.input :latitude
      f.input :longitude
      f.input :rooms
      f.input :garages
      f.input :amenities, as: :check_boxes, collection: ["Pool", "Gym", "Parking", "Garden"] # Example amenities
      f.input :attachments, as: :file, input_html: { multiple: true }
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :video, as: :url
    end
    f.actions
  end
end
