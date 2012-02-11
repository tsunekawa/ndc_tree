require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NdcTree::Node" do

  subject { @tree = NdcTree << [ "913.6" ] }

  it { should be_instance_of NdcTree::Node }
  its(:nodes) {
    should be_instance_of Array
    should have(5).items
  }

end
