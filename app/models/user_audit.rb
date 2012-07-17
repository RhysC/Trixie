class UserAudit
  attr_accessor :name, :email, :emergency_contacts
  
  def set(user)
    @name = user.name
    @email = user.email
    @emergency_contacts = []
    user.emergency_contacts.each do |ec|
      ec_audit = EmergencyContactAudit.new
      ec_audit.set(ec)
      @emergency_contacts << ec_audit
    end
  end
end