require 'spec_helper'

describe Coordinates do
  
  it "should be invalid without latitude" do
    coordinate = Coordinates.new() 
    coordinate.longitude = "-0.1971007"
    coordinate.should_not be_valid
  end
  it "should be invalid without longitude" do
    coordinate = Coordinates.new() 
    coordinate.latitude = "51.49089540000001"
    coordinate.should_not be_valid
  end
  
  it "should be valid with longitude and latitude" do
    coordinate = Coordinates.new() 
    coordinate.latitude = "51.49089540000001"
    coordinate.longitude = "-0.1971007"
    coordinate.should be_valid
  end
end
