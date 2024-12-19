class HomeController < ApplicationController
def index
  @resource = User.new
 @properties = Property.all
  
   

end

end
