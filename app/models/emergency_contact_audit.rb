class EmergencyContactAudit
  attr_accessor :name, :email
  def set(emergency_contact)
    @name = emergency_contact.name
    @email = emergency_contact.email
  end
end