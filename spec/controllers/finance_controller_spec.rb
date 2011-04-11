require 'spec_helper'

describe FinanceController do
  integrate_views

  it "should create sign (pt4)" do
    get :create_sign
    response.should be_success
  end
  it "should manage license"

end
