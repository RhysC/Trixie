require 'rspec'

def current_path
  URI.parse(current_url).path
end

def register_emergency_contacts
  @user.emergency_contacts << EmergencyContact.create(:name => "Gary", :email => "gary@garyemails.com")
end

def raise_distress
  @lat = (rand() * 50)
  @lng = (rand() * 50)
  #hiden fields are best filled in using xpath to get the field
  find(:xpath, "//input[@id='latitude']").set @lat
  find(:xpath, "//input[@id='longitude']").set @lng  
  click_button "Distress"
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
  raise_distress
end

Given /^I have raised a distress notification$/ do  
  create_user
  register_emergency_contacts
  sign_in
  raise_distress
end

Then /^I see an invalid set up message$/ do
  page.should have_content "No emergency contacts have been registered"
end

Then /^I should be taken to the user profile screen$/ do
  current_path.should == user_path(:id => @user.id)
end

Then /^a new incident should created with the correct latitude and longitude$/ do
  Incident.count.should > 0
  Incident.last!.coordinates.latitude.should == @lat.to_s
  Incident.last!.coordinates.longitude.should == @lng.to_s
end

And /^a new notification should be sent with the correct incident$/ do
  pending #- The incident spec use the ActionMailer::Base.deliveries however i would like this to be agnostic of mail
  #IncidentNotifier.any_instance.should_recieve(:notify).with(Incident.last!)
end

Then /^I should be taken to the distress map screen$/ do
  incident = Incident.last!
  current_path.should == distres_path(:id => incident.id)
end

And /^my location should be shown on screen$/ do
  #this requires javascript and connectivity to google maps servers
  coordinates = Incident.last.coordinates
  page.should have_content "initialize(#{@lat}, #{@lng})"
end

When /^I add a photo to the event$/ do
  pending
end

When /^I dump.* the response$/ do
  puts body
end
