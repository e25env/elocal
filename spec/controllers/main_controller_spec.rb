require 'spec_helper'

describe MainController do
  # integrate_views
  before(:each) do
    stub_request :post, "http://elocal-www.local/ws/intranet_ping"
    stub_request(:get, "http://www.whatismyip.com/automation/n09230945.asp")
  end
  it "should update ip address to www server" do
    @songrit= mock_model GmaSongrit, :value=>"http://elocal-www.local/ws/intranet_ping"
    GmaSongrit.should_receive(:find_by_code).with(:www).and_return(@songrit)
    RestClient.should_receive(:post)
    get :index
    response.should be_redirect
  end
  it "should have add/edit person separately; as well as address, company"

end
