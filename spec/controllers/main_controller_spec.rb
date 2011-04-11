require 'spec_helper'

describe MainController do

  it "should update ip address to www server" do
    # debugger
    GmaSongrit.should_receive(:find_by_code).with(:www).and_return(mock_model GmaSongrit, :value=>"http://elocal-www.heroku.com/ws/intranet_ping")
    # controller.songrit(:www).should_receive(:www).and_return("http://elocal-www.heroku.com/ws/intranet_ping")
    RestClient.should_receive(:post)
    get :index
    response.should be_success
  end

end
