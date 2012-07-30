require 'active_model'
class Coordinates 
  include ActiveModel::Validations
  validates_presence_of :latitude, :longitude
  
  attr_accessor :latitude, :longitude, :altitude, :accuracy, :altitudeAccuracy, :heading, :speed
  
  def self.from_params(params)
    coordinates = Coordinates.new() 
    coordinates.latitude = params[:latitude]
    coordinates.longitude = params[:longitude]
    return coordinates
  end
end