require 'spec_helper'

describe DistressController do

  describe "GET 'new'" do
    context "no emergency contacts assigned to the user" do
      before(:each) do
         sign_in_invalid_user
      end
      
      it "should redirect to user/show" do
        get :new
        response.should redirect_to(user_path(:id => @user.id))
      end
      
      it "should show the user an error stating that they cant raise a distress" do
        post :create
        flash[:error].should eq("No emergency contacts have been registered. Distress cant not be raised without emergency contacts.")
      end
    end
    context "emergency contacts have been defined" do
      before(:each) do
         sign_in_valid_user
      end
      
      it "should allow the creation of a distress notification" do
        response.should be_success
      end
    end
  end
  
  describe "POST 'create'" do
    context "no emergency contacts assigned to the user" do
      before(:each) do
         sign_in_invalid_user
      end
      
      it "should redirect to user/show" do
        post :create
        response.should redirect_to(user_path(:id => @user.id))
      end
      
      it "should show the user an error stating that they cant raise a distress" do
        post :create
        flash[:error].should eq("No emergency contacts have been registered. Distress cant not be raised without emergency contacts.")
      end
    end
    context "valid distress is raised" do
      before(:each) do
        sign_in_valid_user
        @coordinates = Coordinates.new() 
        @coordinates.latitude = "51.49089540000001"
        @coordinates.longitude = "-0.1971007"
      end
      
      it "should redirect to distress/show" do
        subject.current_user.stub(:register_incident).and_return(@new_incident)
        post :create
        response.should redirect_to(incident_path(:id => @new_incident.id))
      end
      
      it "should create a new incident for the current user with the given cooridinates" do
        #Arrange/Assert
        subject.current_user.should_receive(:register_incident).with(matches_coordinates(@coordinates)).and_return(@new_incident)
        #ACT
        post :create, {:longitude => @coordinates.longitude, :latitude => @coordinates.latitude }  
      end
    end
  end
  
  #Helper methods
  def sign_in_valid_user
     @user = FactoryGirl.create(:user)
     @user.emergency_contacts << EmergencyContact.create(:name => "frank", :email => "frank@test.com")
     @user.emergency_contacts << EmergencyContact.create(:name => "mary", :email => "mary@test.com")
     sign_in @user
     @new_incident = stub('Incident', :id=> 1234)
  end
  def sign_in_invalid_user
    @user = FactoryGirl.create(:user)
     sign_in @user
  end

  def matches_coordinates(expected) 
    CoordinateMatcher.new(expected)
  end
end
#Matcher helper classes
class CoordinateMatcher 
  def initialize(expected)
    @expected = expected
  end
  def ==(actual)
    @expected.latitude.should == actual.latitude
    @expected.longitude.should == actual.longitude
  end 
end

