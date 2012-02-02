require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NdcTree::Node" do

  before do
    @tree = NdcTree::Node.new
  end

  it "should initialize" do
    @tree.should be_instance_of NdcTree::Node
  end

  it "should has name" do
    @tree.name.should be_instance_of String
  end

  it "should not has accessor of name" do
    (defined? @tree.name="newname").should be_nil
  end

  it "should has weight" do
    @tree.weight.should > 0
  end

  it "should has content" do
    @tree.content.should be_instance_of Hash
  end

  it "should has accessor of weight" do
    @tree.weight = 1
    @tree.weight.should == 1
    @tree.weight+=1
    @tree.weight.should == 2
  end
  
end
