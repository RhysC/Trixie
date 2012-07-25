class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end
  
  #should there be seperate controllers ie 
  #    domain.com/distress/12345/ #shows there tracking of the user and the
  #    domain.com/caution/12345/ #show the tracking of the user only
  #    domain.com/notification/12345/ #show the location of the notification and has no tracking
  
  
  
  #go to a distress page which will load, 
  #get the users coordinates, 
  #send the coordinates as a POST, 
  #create the incident
  #send the notifications
  #move to the tracking page which is just a GET with the incident ID
  
  #def distress #GET
  #  #get the users coordinates, 
  #  #send the coordinates as a POST,
  #end
  #def distress #temp action not the longterm startegy
  #  #create the incident with the given cooridinates (which will inturn send the notifications)
  #  #move to the tracking page which is just a GET with the incident ID
  #end
  
  #def tracking
  #  #can the web server recieve emails (as initial comms format)? move to websockets now or later?
  #  #for each EC wait for the response and set the incident EC as acknowledged  
  #end
end
