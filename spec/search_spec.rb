require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NdcTree::Node searching" do
  subject { NdcTree << %w{ 913.6 913.6 914 400 007 515 } }

  it {
    result = subject["913.6"]
    result.should be_instance_of NdcTree::Node
    result.name.should == "913.6"
    result.weight.should == 2
  }

  it {
    result = subject["611"]
    result.should be_nil
  }

  it {
    result = subject.search(/^9/)
    result.should be_instance_of Array
    result.should have(5).items
  }

  it {
    result = subject.search(/^1/)
    result.should be_instance_of Array
    result.should have(0).items
  }

end
