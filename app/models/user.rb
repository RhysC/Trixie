class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :emergency_contacts, :dependent => :destroy
  has_many :incidents
  
  def register_incident(coordinates)
    incident = Incident.create(:user => self, :coordinates => coordinates)  
    IncidentMailer.distress_email(incident).deliver 
    return incident 
  end
end
