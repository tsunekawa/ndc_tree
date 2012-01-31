# -*- coding:utf-8 -*-
$:.unshift File.join(File.dirname(__FILE__), %w{ .. lib })

require 'ndc_tree'

tree = NdcTree << %w{
  913.6
  411
  007
  913.6
  914
  914.6
  913.6
  913.6
  913.6
  913.6
}

filepath = File.join(File.dirname(__FILE__), %w{ .. data })
tree.print_image(:gif=>File.join(filepath,%w{output.gif})) do |g|
  g.node[:style] = "filled"
  g.node[:shape] = "note"
  g.node[:color] = "black"
  g.node[:fontcolor] = "white"
end

