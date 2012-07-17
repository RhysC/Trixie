class DistressController < ApplicationController
  before_filter :authenticate_user!
  
  def new #GET
     error_and_redirect if current_user.emergency_contacts.empty?
  end
  
  #the current geo location coordinates object as describe here :
  #interface Coordinates { double latitude; double longitude; double? altitude; double accuracy; double? altitudeAccuracy; double? heading; double? speed;};
  
  def create #POST
    if current_user.emergency_contacts.empty?
      error_and_redirect
      return
    end
    user_coordinates = create_coordinates(params) 
    incident = current_user.register_incident(user_coordinates)
    redirect_to :action => 'show', :id => incident.id 
  end
  
  def show
    @incident = Incident.find(params[:id])
    @coordinates = @incident.coordinates 
  end
  
  private
  def error_and_redirect
    flash[:error] = "No emergency contacts have been registered. Distress cant not be raised without emergency contacts."
    redirect_to(user_path(:id => current_user.id))
  end
  def create_coordinates(params)
    coordinates = Coordinates.new() 
    coordinates.latitude = params[:latitude]
    coordinates.longitude = params[:longitude]
    return coordinates
  end
end