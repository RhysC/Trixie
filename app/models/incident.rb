require 'date'

class Incident < ActiveRecord::Base
  belongs_to :user
  serialize :user_audit, UserAudit
  serialize :coordinates, Coordinates
  #serialize :notifications
  
  after_initialize :set_defaults
  
  private
  def set_defaults
    write_attribute(:raised_on, Time.now)
    self.user_audit = UserAudit.new()
    self.user_audit.set(self.user)
  end
end