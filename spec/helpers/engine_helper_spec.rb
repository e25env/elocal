require 'spec_helper'

describe EngineHelper do

  it "should check if view contains file_field" do
    f1= File.read("app/views/office/doc_in/register.rhtml")
    helper.ajax(f1).to_s.should == "false"
    f2= File.read("app/views/office/doc_in/create_search.rhtml")
    helper.ajax(f2).to_s.should == "true"
  end

end
