require 'spec_helper'

describe WwwController do

  it "should post news to internet server" do
    post :create
    response.should be_success
  end
  it "should queue post if network not available"

end
