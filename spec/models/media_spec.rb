require 'spec_helper'

describe Media do
  before(:each) do
    @valid_attributes = {
      :post_id => 1,
      :file_name => "value for file_name",
      :content_type => "value for content_type",
      :size => 1,
      :url => "value for url",
      :gma_user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Media.create!(@valid_attributes)
  end
end
