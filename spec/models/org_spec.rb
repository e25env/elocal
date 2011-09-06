require 'spec_helper'

describe Org do
  it "should return logo image if supplied" do
    File.should_receive(:exist?).and_return(false)
    Org.logo.should == "logo_elocal.png"
    File.should_receive(:exist?).and_return(true)
    Org.logo.should == "logo.png"
  end
  # it "could check license" do
  #   License.stub(:new).and_return @l
  #   @l.should_receive(:license).and_return "starter"
  #   Org.license.should == "starter"
  #   @l.should_receive(:license).and_return "PdbpCpM/qCFFKDphN7Xb7nqun6Lbx7O0/kDxf8Kx+4+NBZEh1Tv5Y6sX7dOH Hrzjsk3DuugqTeOMQ0FBcHEJng//yAsIkmK/JAuB0nC87eQGseigCBwiscd5 do77As0IU/+Kwe56yfis+Oe82w55/6K6RNb9o1QfzgFo5Inmah/y3YV5i5Em 5M2R+4naEGXTLQ/nOI6CpmnpAyNbK79wSxQxJkvkc72bjEbo9fNAe6Penj1B j5A0HLwX+F2OD1MV4Q41e8FDffddkVaD7N7kjSJmZYQl0mnkH7BEXeo79XAm bhZnbOiqRZtT6duJfgbx3mAf1PtTv8gkGUKT+0qHNA=="
  #   Org.license.should == "elocal:songrit:songrit@gmail.com:110909"
  # end
end
