describe "NdcTree#Node.delete" do

  before(:each) {
    @tree = NdcTree << %w{ 913.6 913.6 007 }
  }

  it {
    @tree.delete "007"
    lambda{ @tree["007"] }.should be_nil
    @tree.nodes should == 4
  } 

  it {
    @tree.delete "913.6"
    lambda{ @tree["913.6"] }.should_not be_nil
    subject.nodes should == 7
    @tree.delete "913.6"
    lambda{ @tree["913.6"] }.should be_nil
    subject.nodes should == 3
  } 

end
