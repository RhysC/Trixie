Feature: Distress notification
  In order to get assistance when is distress
  A user
  Should be able to raise a distress notification

	Scenario: User has no emergency contacts
      Given I do not have any emergency contacts registered
       When I raise a distress notification
       Then I see an invalid set up message
        And I should be taken to the user profile screen

	Scenario: User has defined emergency contacts
      Given I have registered some emergency contacts 
       When I raise a distress notification
       Then a new incident should created with the correct latitude and longitude
        And I should be taken to the distress map screen
        And my location should be shown on screen
        And a new notification should be sent with the correct incident
	      
  Scenario: Distressed user add key information
	    Given I have raised a distress notification
 	      And I am on the distress notifications page
	     When I add a photo and comment to the event
	     Then the photo should be added to the incident
	      And the comment should be added to the incident 
	      And the update is time stamped and geo tagged
	      And my emergency contacts are notified of the addition of the new information
	      And the notification provides a link to the incident
	      
	  

        #	Scenario: User is tracked upon making a distress notification
        #           NOTE- i now think that this may not be appropriate for the framework test suite - this should whoever be included in on the client application test suite
        #      Given I have raised a distress notification 
        #       When I change location 
        #       Then I should broadcast my new location 
        #	      And the broadcast should be timestamped

        #	Scenario: Emergency Contacts can acknowledge a distress notification
        #      Given I have received a distress notification 
        #       When I acknowledge the notification 
        #       Then I should reply to the server with my location, a timestamp and an optional comment

        #	Scenario: Emergency Contacts are tracked upon acknowledgement ????
        #      Given I have acknowledged a distress notification 
        #       When I change location 
        #	     Then I should update the incident with my new location 
        #	      And the broadcast should be timestamped

        #	Scenario: Distressed user loses connection
        #	    Given I have received a distress notification
        #	      And I have a location of the distressed user
        #	     When The distressed user loses connection
        #	     Then I am notified of the time of disconnection
        #	      And I should see the last known location with the time of the update