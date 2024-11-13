class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(sign_up_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: 'Account created successfully. You are now logged in.'
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      redirect_to root_path
    end
  end

  def edit
    @resource = current_user
  end

 def update
  @user = current_user
  if needs_password_update?(account_update_params)
    if @user.update_with_password(account_update_params)
      bypass_sign_in(@user)
      redirect_to edit_user_registration_path, notice: 'Profile and password updated successfully.'
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  else
    if @user.update(account_update_params.except(:current_password, :password, :password_confirmation))
      bypass_sign_in(@user)
      redirect_to edit_user_registration_path, notice: 'Profile updated successfully.'
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end
end
  private

  def sign_up_params
  params.require(:user).permit(
    :name, :description, :position, :phone_number, :office_number, 
    :office_address, :job, :email, :password, :password_confirmation, 
    :personal_address, :facebook, :twitter, :linkedin, :image
  )
end
def needs_password_update?(params)
  params[:password].present? || params[:password_confirmation].present?
end

def account_update_params
  params.require(:user).permit(
    :name, :description, :position, :phone_number, :office_number, 
    :office_address, :job, :email, :password, :password_confirmation, 
    :current_password, :personal_address, :facebook, :twitter, :linkedin, :image
  )
end

end
