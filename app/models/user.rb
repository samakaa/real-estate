class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one_attached :image
   has_many :properties,:foreign_key => 'agent_id', dependent: :destroy
   enum role: { regular: 'regular', agent: 'agent', admin: 'admin' }

     def self.ransackable_attributes(auth_object = nil)
    [
      "id", "name", "email", "job", "position", "phone_number", "office_number", 
      "office_address", "personal_address", "facebook", "twitter", "linkedin", 
      "description", "role", "created_at", "updated_at"
    ]
  end

  # Add searchable associations (if any, e.g., related properties)
  def self.ransackable_associations(auth_object = nil)
    [] # Add associations like ["properties"] if applicable
  end
end

