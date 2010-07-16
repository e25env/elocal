require 'spec_helper'

describe Waypoint do
  before(:each) do
    @valid_attributes = {
      :code => "value for code",
      :name => "value for name",
      :lat => 1.5,
      :lng => 1.5,
      :description => "value for description",
      :pic => "value for pic",
      :cat_id => 1,
      :morning => false,
      :afternoon => false,
      :evening => false,
      :address => "value for address",
      :city => "value for city",
      :state_id => 1,
      :zip => "value for zip",
      :country_id => 1,
      :phone => "value for phone",
      :email => "value for email",
      :www => "value for www",
      :tgel_user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Waypoints.create!(@valid_attributes)
  end
end
