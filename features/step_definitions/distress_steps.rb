require 'rspec'
require 'FileUtils'
require 'active_support'

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

def clean_test_upload_folder
  #Clean out the test upload folder
  path = "#{Rails.root}/public/uploads/test/incident_history/"
  if File.exists?(path) && File.directory?(path)
      puts "removing test upload folder : #{path}"
      FileUtils.rm_rf  path
  end
end
Before do
  clean_test_upload_folder  
end
After do
  clean_test_upload_folder  
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
  #pending #- The incident spec use the ActionMailer::Base.deliveries however i would like this to be agnostic of mail
  #IncidentNotifier.any_instance.should_recieve(:notify).with(Incident.last!)
  ActionMailer::Base.deliveries.should have(1).things
end

Then /^I should be taken to the distress map screen$/ do
  incident = Incident.last!
  current_path.should == incident_path(:id => incident.id)
end

And /^I am on the distress notifications page$/ do
  incident = Incident.last!
  current_path.should == incident_path(:id => incident.id)
end

And /^my location should be shown on screen$/ do
  #this requires javascript and connectivity to google maps servers
  coordinates = Incident.last.coordinates
  page.should have_content "initialize(#{@lat}, #{@lng})"
end

When /^I add a photo and comment to the event$/ do
  attach_file "picture", "#{Rails.root}/features/resources/Sunflower.gif"
  @comment = ('a'..'z').to_a.shuffle[0,8].join
  fill_in "comment" , :with => @comment
  click_button "update"
end

Then /^the photo should be added to the incident$/ do
  Incident.last.incident_histories.last.picture.url.should == "/uploads/test/incident_history/picture/1/Sunflower.gif"
end

Then /^the comment should be added to the incident$/ do
  Incident.last.incident_histories.last.comment.should == @comment
end

Then /^the update is time stamped and geo tagged$/ do
  incident_update = Incident.last.incident_histories.last
  incident_update.created_at.should be_between(5.seconds.ago, Time.now)
end

Then /^my emergency contacts are notified of the addition of the new information$/ do
  ActionMailer::Base.deliveries.should have(2).things
end

Then /^the notification provides a link to the incident$/ do
  incidentid = Incident.last.id
  ActionMailer::Base.deliveries.last.body.should include "/incidents/#{incidentid}"
end



When /^I dump.* the response$/ do
  puts body
end
