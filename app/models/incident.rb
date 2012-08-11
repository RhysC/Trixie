require 'date'
#TODO maybe attachment is a better name than picture
class Incident < ActiveRecord::Base
  belongs_to :user
  has_many :incident_histories
  serialize :user_audit, UserAudit
  serialize :coordinates, Coordinates
  
  after_initialize :set_defaults
  after_save :notify
  
  def update_with(params)
    coordinates = Coordinates.from_params(params)
    incident_histories.create(:picture => params[:picture], :coordinates => coordinates, :comment => params[:comment])
  end
  
  def notify
    IncidentNotifier.new().notify(self)
  end
  
  private
  def set_defaults
    self.user_audit = UserAudit.new()
    self.user_audit.set(self.user)
  end
  
end