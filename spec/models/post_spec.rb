require 'spec_helper'

describe Post do
  before(:each) do
    @valid_attributes = {
      :subject => "value for subject",
      :body => "value for body",
      :stick => false,
      :post_type => 1,
      :begin_on => Date.today,
      :end_on => Date.today,
      :gma_user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Post.create!(@valid_attributes)
  end
end
