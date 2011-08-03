require 'spec_helper'

describe OfficeController do
  integrate_views

  before do
    @employee= mock_model(Employee, :code=> nil, :person_id=> 1, :position=> nil, :position_on=> nil, :section_id=> nil, :level=> nil, :salary=> nil, :appointed_by=> nil, :position_code=> nil, :address_id=> 20, :address_reg_id=> 21, :begin_gov_service_on=> "2010-12-31", :retired_on=> "2054-09-30", :spouse_id=> 2, :father_id=> 3, :mother_id=> 4, :address_relative_id=> 22, :skill=> "", :highest_education_id=> nil, :blood_type=> "O", :status=> 1, :photo=> "/engine/document/6", :taken_on=> "2011-01-22", :signature=> nil, :leave_balance=> 0, :manpower_id=> nil, :manpower_code=> "", :comment=> "", :gma_user_id=> 2)
  end
  #Delete this example and add some real ones
  it "show employee" do
    Employee.stub(:exists?).and_return(true)
    Employee.should_receive(:find).and_return(@employee)
    @employee.stub(:person)
    get :employee, :id=>1
  end

end
