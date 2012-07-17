class EmergencyContact < ActiveRecord::Base
  belongs_to :user
  validates :name,  :presence => true
  validates :email, :presence => true,
                    :length => { :minimum => 5 } #this needs to be a little stronger than this
end