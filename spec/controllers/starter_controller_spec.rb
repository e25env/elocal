require 'spec_helper'

describe StarterController do
  integrate_views

  it "show sections" do
    Section.should_receive(:all).and_return([])
    get :sections
  end

end
