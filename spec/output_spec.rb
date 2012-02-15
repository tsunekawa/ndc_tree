describe "NdcTree::Node#output" do
  it "returns true when output format is not String" do
    tree = NdcTree << %w{ 913.6 400 713 }
    tree.print_image(:png=>"test.png").should == true
  end

  it "returns binary data when output format is String" do
    tree = NdcTree << %w{ 913.6 400 713 }
    tree.print_image(:png=>String).should be_instance_of String
  end
end
