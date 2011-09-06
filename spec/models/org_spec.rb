require 'spec_helper'

describe Org do
  it "should return logo image if supplied" do
    File.should_receive(:exist?).and_return(false)
    Org.logo.should == "logo_elocal.png"
    File.should_receive(:exist?).and_return(true)
    Org.logo.should == "logo.png"
  end
end
