class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :description, :text
    add_column :users, :position, :string
    add_column :users, :phone_number, :string
    add_column :users, :office_number, :string
    add_column :users, :office_address, :string
    add_column :users, :job, :string
    add_column :users, :personal_address, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :linkedin, :string
  end
end
