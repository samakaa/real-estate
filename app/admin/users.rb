ActiveAdmin.register User do
  # Permitted parameters for strong parameters
  permit_params :email, :name, :role, :position, :phone_number, :office_number,
                :office_address, :job, :personal_address, :facebook, :twitter,
                :linkedin, :description, :image, :password, :password_confirmation

  # Index page: Customize the columns displayed
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column :phone_number
    column :office_address
    column :created_at
    actions
  end

  # Filters
  filter :email
  filter :name
  filter :role
  filter :phone_number
  filter :created_at

  # Show page: Display user details
  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :role
      row :position
      row :phone_number
      row :office_number
      row :office_address
      row :job
      row :personal_address
      row :facebook
      row :twitter
      row :linkedin
      row :description
      row :image do |user|
        image_tag user.image if user.image.present?
      end
      row :created_at
      row :updated_at
    end
  end

 form do |f|
  f.inputs "User Details" do
    f.input :role, as: :select, collection: User.roles.keys.map { |role| [role.titleize, role] }, prompt: "Select Role"
    f.input :email
    f.input :name
    f.input :position
    f.input :phone_number
    f.input :office_number
    f.input :office_address
    f.input :personal_address
    f.input :facebook
    f.input :twitter
    f.input :linkedin
    f.input :description
    f.input :image, as: :file
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end

end
