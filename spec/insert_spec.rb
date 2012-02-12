require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NdcTree <<" do

  subject { @tree = NdcTree << [ "913.6" ] }

  it { should be_instance_of NdcTree::Node }

  its(:name) { should == "root" }
  its(:nodes) {
    should be_instance_of Array
    should have(5).items
  }
  its(:weight) { should >= 1 }
  its(:children) {
    should have(1).items 

    corrects = [ "9**", "91*", "913", "913.6" ]
    corrects.inject(subject.first) do |node, correct|
      node.name.should  == correct
      if node.is_leaf? then
	next node
      else
        node.children.should have(1).items 
        next node.children.first
      end
    end
  }
  its(:content) {
    should be_instance_of Hash
    should have(0).items
  }

end
