require 'spec_helper'

describe MainController do

  it "should update ip address to www server" do
    if WWW
      RestClient.should_receive(:post)
    end
    get :index
    response.should be_success
  end

end
