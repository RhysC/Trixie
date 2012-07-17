require 'active_model'
class Coordinates 
  include ActiveModel::Validations
  validates_presence_of :latitude, :longitude
  
  attr_accessor :latitude, :longitude, :altitude, :accuracy, :altitudeAccuracy, :heading, :speed
end