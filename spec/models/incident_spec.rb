require 'spec_helper'

describe Incident do
  #
  # Please Note: all incident creation should come via the USER domain object. 
  # Incidents are not relevent in their own isolated context
  #
  describe "when creating a incident" do
    before(:each) do
      @expected_date = stub_out_now()
    end
    it "should default the raised on date to now" do
      incident = Incident.create(:user => set_up_user(), :coordinates => set_up_coordinates()) 
      incident.raised_on.should == @expected_date
    end
    it "should have the user that raise the incident" do
        user = set_up_user()
        incident = Incident.create(:user => user, :coordinates => set_up_coordinates()) 
        incident.user.should == user
    end
    it "should have the coordinates of the incident" do
        coordinates = set_up_coordinates()
        incident = Incident.create(:user => set_up_user(), :coordinates => coordinates) 
        incident.coordinates.latitude.should == coordinates.latitude
        incident.coordinates.longitude.should == coordinates.longitude
    end
  end
  
  describe "when creating an incident from a user" do
    attr_reader :expected_date
    before :each do
      ActionMailer::Base.deliveries = []
      @user = set_up_user()
      @coordinates = set_up_coordinates()
      @expected_date = stub_out_now()
      @incident = @user.register_incident(@coordinates)
    end
   
     it "should create an incident with the current date" do
       @incident.raised_on.should == @expected_date
     end
     it "should persist a copy of profiles own current objects graphs state" do
       @incident.user_audit.name.should == @user.name
       @incident.user_audit.email.should == @user.email
     end
     it "should not persist object graph of previous incidents" do
        coordinates = Coordinates.new()
        coordinates.latitude = "51.49089540000001"
        coordinates.longitude = "-0.1971007"
        incident2 = @user.register_incident(coordinates)
        lambda {incident2.user_audit.incidents}.should raise_error NoMethodError 
     end
     it "should send notification" do
       ActionMailer::Base.deliveries.should have(1).things
     end
     it "should send notification to each of the listed emergency contacts" do
       receipients = ActionMailer::Base.deliveries[0].to
       receipients.should include "frank@test.com"
       receipients.should include "mary@test.com"
     end
     it "should send notification with the details of the person in distress" do
         ActionMailer::Base.deliveries[0].subject.should == "#{@user.name} is in distress"
     end
     it "should send notification with the location of the person in distress" do
        ActionMailer::Base.deliveries[0].body.should include "Latitude : #{@coordinates.latitude}" 
        ActionMailer::Base.deliveries[0].body.should include "Longitude : #{@coordinates.longitude}" 
     end
     pending "should audit the sending of notifications" # is this required at the moment?
     pending "should be able to acknowlege the receipt of a notification" # maybe? need to think what is best
  end
  
  private
  def set_up_user
    user = User.create!({ 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    })
    user.emergency_contacts << EmergencyContact.create(:name => "frank", :email => "frank@test.com")
    user.emergency_contacts << EmergencyContact.create(:name => "mary", :email => "mary@test.com")
    user.save
    return user
  end
  def set_up_coordinates
    coordinates = Coordinates.new() 
    coordinates.latitude = "51.49089540000001"
    coordinates.longitude = "-0.1971007"
    return coordinates
  end
  def stub_out_now
    expected_date = Time.mktime(1997,6,21) # is this the best place for this?
    Time.stub!(:now).and_return(expected_date)
    return expected_date
  end
end
