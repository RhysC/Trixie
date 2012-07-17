require 'spec_helper'

describe EmergencyContact do
  
  it "should be invalid without email" do
    emergency_contact = EmergencyContact.create(:name => "frank")
    emergency_contact.should_not be_valid
  end
  it "should be invalid without name" do
    emergency_contact = EmergencyContact.create(:email => "frank@test.com")
    emergency_contact.should_not be_valid
  end
  
  it "should be valid with name and email address" do
    emergency_contact = EmergencyContact.create(:name => "frank", :email => "frank@test.com")
    emergency_contact.should be_valid
  end
end
