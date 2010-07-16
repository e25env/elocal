require 'spec_helper'

describe Cat do
  before(:each) do
    @valid_attributes = {
      :code => "value for code",
      :name => "value for name",
      :tgel_user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Cat.create!(@valid_attributes)
  end
end
