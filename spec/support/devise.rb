RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  #config.extend ControllerMacros, :type => :controller # is this required?
end

