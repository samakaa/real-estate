class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    root_path # Change this to the path you want users to go after login
  end

   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:image, :email])
  end
end
