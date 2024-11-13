class AddDetailsToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :address, :string
    add_column :properties, :zip_code, :string
    add_column :properties, :country, :string
    add_column :properties, :province_state, :string
    add_column :properties, :neighborhood, :string
    add_column :properties, :unit_price, :decimal, precision: 15, scale: 2
    add_column :properties, :type, :string
    add_column :properties, :status, :string
    add_column :properties, :size, :integer
    add_column :properties, :land_area, :integer
    add_column :properties, :rooms, :integer
    add_column :properties, :garages, :integer
    add_column :properties, :year_built, :integer
    add_column :properties, :amenities, :json
  end
end
