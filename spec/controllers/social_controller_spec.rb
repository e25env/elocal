require 'spec_helper'

describe SocialController do
  describe "senior" do
    before do
      $xvars= {:gma_service_id=>126, :senior_id=>nil, :host=>"elocal.local", :enter=>{:person=>{"nid"=>"3100800331137"}, :xmain_id=>"701", :action=>"end_form", :runseq_id=>"2123", :step=>"1", :commit=>"ดำเนินการต่อ >", :controller=>"engine", :senior=>{"underprivileged"=>"1", "person_id"=>"1", "budget"=>"1"}}, :create_senior=>"/social/seniors", :p=>{"service"=>"add_senior", "module"=>"social", "action"=>"init", "controller"=>"engine", "return"=>"/social/seniors"}, :total_form_steps=>1, :user_id=>2, :total_steps=>3, :custom_controller=>"SocialController", :referer=>"http://elocal.local/social/seniors", :id=>nil, :current_step=>2}
    end
    it "show seniors" do
      # integrate_views
      get :seniors
      response.should render_template "social/seniors"
    end
    it "create senior" do
      Senior.delete_all
      get :create_senior
      $xvars[:senior_id].should_not be_nil
      # should not create duplicate
      get :create_senior
      $xvars[:senior_id].should be_nil
    end
  end
  
end
