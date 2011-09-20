require 'spec_helper'

describe FinanceController do
  integrate_views

  it "show sample financial reports" do
    # User.should_receive(:find).and_return(mock_model(User))
    get :daily_print
    get :trial
    get :income
    get :banks
    get :revenue_table
    get :expense_table
  end
  it "สามารถแก้ไขป้ายได้"
  it "สามารถลบป้ายได้"
  it "should manage license"

end
