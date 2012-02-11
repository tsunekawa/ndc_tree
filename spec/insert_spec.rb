require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NdcTree <<" do

  subject { @tree = NdcTree << [ "913.6" ] }

  it { should be_instance_of NdcTree::Node }

  its(:name) { should == "root" }
  its(:nodes) {
    should be_instance_of Array
    should have(5).items
  }
  its(:children) {
    should have(1).items
    subject.first.name.should  == "9**"
  }

end
