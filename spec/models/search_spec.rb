require 'spec_helper'

describe Search do
  before(:each) do
    @valid_attributes = {
      :q => "value for q",
      :ip => "value for ip",
      :tgel_user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Search.create!(@valid_attributes)
  end
end
