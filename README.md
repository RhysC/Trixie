Trixie
------

Security For the masses

TODO
====

* remove redundant files 
  * see all the bootstrap js,css file
  * all the generated css/coffee files in app
  * run http://developer.yahoo.com/yslow/
    * look at header expiry and gzip compression - http://stackoverflow.com/questions/7792648/how-to-get-gzip-and-expires-header-on-a-rails-3-1-1-app-on-heroku-cedar
    * why are all the asset fils adding a query string to the url? (eg ?body=1). surely this makes them less cacheable?
    
* ensure we are git ignoring the generated files
* ensure the github repo is clean
* review test coverage for exiting functionality - add test where coverage is inadequate
  * Need to add tests where there is no connectivity - i.e. can not hit google for email.. (what would i do in this instance?)
* push to Heroku

* error pages need to be formatted appropriately

* investigate continuous deployment servers

Improvements
============

integrate Omni auth 
* set up notification types for each provider ( eg wall, circles, tweet).
  encourage the user of neighbourhood watch i.e. a warwick road circle

Notification mechanisms

FREE
* SMTP
* Omni auth (as above - wall, circle etc)

Paid Service
* 999
* SMS
* Push (ie APN, Android Push etc)
* API based (eg 3rd Party). Note the consumers of the API could pay or subsidise the user costs
________________________

License