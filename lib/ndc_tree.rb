# -*- coding:utf-8 -*-
$:.unshift File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'tree'
require 'graphviz'

module NdcTree
  extend self
  VERSION = File.read(File.join(File.dirname(__FILE__),%w{ .. VERSION}))

  def <<(value)
    Node.new << value
  end

  autoload :Node, "ndc_tree/node.rb"
end
