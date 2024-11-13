# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  respond_to :html, :js

  def create
    super do |resource|
      if request.format.js? && resource.errors.empty?
        flash.now[:notice] = "Successfully logged in!"
        return
      end
    end
  end

  def destroy
    super do |resource|
      if request.format.js?
        flash.now[:notice] = "Successfully logged out!"
        return
      end
    end
  end
end
