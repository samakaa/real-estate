class AddLabelAndVideoToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :label, :string
    add_column :properties, :video, :string
  end
end
