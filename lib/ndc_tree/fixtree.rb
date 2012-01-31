#!ruby -Ku
# -*- coding:utf-8 -*-

require 'rubygems'
require 'tree'
require 'graphviz'

module Tree
  class TreeNode
    # Zhang-Shashaアルゴリズムを適用できるように木のライブラリを改造

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

    def left_dec
      if self.has_children?
        return self.children.first
      else
        return self
      end
    end

    def key_roots
    # key roots であるノードの配列を返す
      ary = Array.new
      polist=self.post_order
      polist.each_index{|i|
        node=polist[i]
        if node.parent.nil? or node.parent.left_dec != node.left_dec
          ary << node 
        end
      }
      return ary
    end

    def post_order
    # 帰りがけ順でソートしたノードの配列を返す
      return TreeNode._post_order_indexing(self)
    end

    protected

    def TreeNode._post_order_indexing(tree,id=1,ary=Array.new)
    # post_orderを算出するための再帰メソッド
      if tree.has_children?
        tree.children.each {|node|
          TreeNode._post_order_indexing(node,id,ary)
        }
      end
      ary << tree
      return ary
    end

  end

end

