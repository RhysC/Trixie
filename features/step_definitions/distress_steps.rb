def current_path
  URI.parse(current_url).path
end

def register_emergency_contacts
  @user.emergency_contacts << EmergencyContact.create(:name => "Gary", :email => "gary@garyemails.com")
end

Given /^I do not have any emergency contacts registered$/ do
  create_user
end

Given /^I have registered some emergency contacts$/ do
  create_user
  register_emergency_contacts
end

When /^I raise a distress notification$/ do
  sign_in
  visit '/distress/new'
  if(current_path == new_distres_path)
    visit '/distress/', {:latitude => "23.2323", :longitude => "43.232" }
  end
end

Then /^I see an invalid set up message$/ do
  page.should have_content "No emergency contacts have been registered"
end

Then /^I should be taken to the user profile screen$/ do
  current_path.should == user_path(:id => @user.id)
end

Then /^I should be taken to the distress map screen$/ do
  #This requires Javascript to retrieve geolocation and redirection to #create
  puts "should be on the ditress show screen - #{current_path}"
  incident = Incident.last!
  current_path.should == distres_path(:id => incident.id)
end

And /^my location should be shown on screen$/ do
  #this requires javascript and connectivity to google maps servers
  coordinates = Incident.last.coordinates
  page.should have_content "initialize(#{coordinates.latitude}, #{coordinates.longitude})"
end
