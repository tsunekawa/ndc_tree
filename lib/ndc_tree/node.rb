# -*- coding:utf-8 -*-

class NdcTree::Node < Tree::TreeNode
  class InputNdcError < Exception;end

  def initialize(name="root",content={})
    content[:weight]=1
    super(name, content)
  end

  def nodes
    self.to_a
  end

  def sort!
    unless self.is_leaf? then
      @children.sort!.map{|node| node.sort!}
    end
    self
  end

  def sort
    node = self.dup
    node.sort!
  end

  def weight
    self.content[:weight]
  end

  def weight=(value)
    self.content[:weight]=value
  end

  def <<(value)
    case value.class.name.to_sym
      when :String
	add_ndc(value)
      when :Array
	value.flatten.each{|v| add_ndc(v) }
      when :Node
	super
      else
	raise TypeError,"#{value} is not valid"
    end 
    self
  end

  def add_ndc (str)
    unless /^[0-9]{3}(\.[0-9]+){0,1}$/ =~ str
      raise InputNdcError, "入力された文字列(#{str})はNDCコードではありません" 
    end

    labels=Array.new
    name = ""
    node = self
    str.split(//).each do |n|
      name+=n
      asta= "*"*([3-name.size,0].max) 
      next if n=="."
      label = name+asta
      if node[label].nil? then
	unless node.is_leaf? then
	  index = -1 
	else
	  index = node.children.inject(-1) {|count,n|
	    (n.name > label) ? count : count+1
	  }
	end
	node.add(self.class.new(label),index)
      else
	node[label].weight+=1
      end
      node = node[label]
    end

    self
  end

  def marshal_load(dumped_tree_array)
    nodes = { }
    dumped_tree_array.each do |node_hash|
      name        = node_hash[:name]
      parent_name = node_hash[:parent]
      content     = Marshal.load(node_hash[:content])

      if parent_name then
	nodes[name] = current_node = self.class.new(name, content)
	nodes[parent_name].add current_node
      else
	# This is the root node, hence initialize self.
	initialize(name, content)

	nodes[name] = self    # Add self to the list of nodes
      end
    end
  end

  def print_image(opts={:gif=>"ndc_tree.gif"},&block)
    sort!

    g = GraphViz::new("G")
    set_default_style
    to_graphviz(g,opts)

    yield g if block_given?

    g.output(opts)
  end

  protected

  def set_default_style
    g = GraphViz::new("G")
    g.node[:style] = "filled"
    g.node[:shape] = "note"
    g.node[:color] = "black"
    g.node[:fontcolor] = "white"
  end

  def to_graphviz(g,opts={})
    case weight
    when 0..1;color="black";
    when 2..4;color="blue";
    else;color="red";
    end

    gnode = g.add_nodes(name+"(#{weight})")
    gnode[:color] = color

    unless is_leaf? then
      children.each do |node|
	g.add_edges(gnode, node.to_graphviz(g,opts))
      end
    end
    gnode
  end

end
