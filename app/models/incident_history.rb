class IncidentHistory < ActiveRecord::Base
  belongs_to :incident
  mount_uploader :picture, PictureUploader
  serialize :coordinates, Coordinates
end
