class IncidentsController < ApplicationController
  before_filter :authenticate_user!
   
  #the current geo location coordinates object as describe here :
  #interface Coordinates { double latitude; double longitude; double? altitude; double accuracy; double? altitudeAccuracy; double? heading; double? speed;};
  
  def create #POST
    if current_user.emergency_contacts.empty?
      error_and_redirect
      return
    end
    user_coordinates = Coordinates.from_params(params)
    incident = current_user.register_incident(user_coordinates)
    redirect_to :action => 'show', :id => incident.id 
  end
  
  def show
    @incident = Incident.find(params[:id])
    @coordinates = @incident.coordinates 
  end
  
  def update
    incident = Incident.find(params[:id])
    incident.update_with(params)
    incident.save!
    redirect_to :action => 'show', :id => params[:id]
  end
  
  private
  def error_and_redirect
    flash[:error] = "No emergency contacts have been registered. Distress cant not be raised without emergency contacts."
    redirect_to(user_path(:id => current_user.id))
  end
end