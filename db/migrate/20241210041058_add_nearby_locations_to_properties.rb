class AddNearbyLocationsToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :nearby_locations, :json
  end
end
