module Forest
  class Forest
   ORIGIN      = "ORIGIN"
   DELETE_TREE = 1
   INSERT_TREE = 1
   EDIT_LABEL  = 1

   protected
   def l(index,list)
     if list[index].has_children?
       return list.index(list[index].children.first)
     else
       return index
     end
   end

   def t(index1,index2)
     if index1 <= index2
       return "#{index1}to#{index2}"
     else
       return ORIGIN
     end
   end

   def insert_cost(tree)
     return tree.size
   end

   def delete_cost(tree)
     return tree.size
   end

   def edit_cost(atree,btree)
     if atree.name == btree.name
       cost = 0
     else
       cost = delete_cost(atree)+insert_cost(btree)
     end

     # return cost
     return 0
   end

  public

   def print_d
     printf("| %8s ", "")
     @d.first.each_index{|key| printf("| %8s ", key)}
     printf("\n")

     @d.each_index{|key1|
       printf("| %8s ",key1)
       @d[key1].each_index{|key2|
         printf("| %8s ",@d[key1][key2])
       }
        printf("\n")
      }
      printf("\n")
    end

    def print_fd(r=/^.*$/)
      x_keys = ["ORIGIN"]+@fd.keys.find_all{|key| key=~r }.sort
      y_keys = ["ORIGIN"]+@fd.values[0].keys.find_all{|key| key=~r }.sort

      ([""]+y_keys).each{|key| printf("| %8s ", key)}
      printf("\n")

      x_keys.each{|key1|
        printf("| %8s ",key1)
        y_keys.each{|key2|
          printf("| %8s ",@fd[key1][key2])
        }
        printf("\n")
      } 
      printf("\n")
    end

    def edit_distance(atree, btree)
       #atree=atree.sort
       #btree=btree.sort
       d = Array.new(atree.size){|index| Array.new(btree.size){|index2| nil} }
      fd = Hash.new {|hash,key| hash[key]=Hash.new(nil)}
      alist = atree.post_order
      blist = btree.post_order

      atree.key_roots.each do |xnode|
        x = alist.index(xnode)
        btree.key_roots.each do |ynode|
          y = blist.index(ynode)
          fd[ORIGIN][ORIGIN] = 0
         
          l(x,alist).upto(x) do |i|
            fd[t l(x,alist),i ][ORIGIN]=fd[t l(x,alist),i-1 ][ORIGIN]+delete_cost(alist[i])
          end
          l(y,blist).upto(y) do |j|
            fd[ORIGIN][t l(y,blist),j ]=fd[ORIGIN][t l(y,blist),j-1]+insert_cost(blist[j])
          end

          l(x,alist).upto(x) do |i|
            l(y,blist).upto(y) do |j|

              m = [ fd[t l(x,alist),i-1][t l(y,blist),j]+delete_cost(alist[i]),
                    fd[t l(x,alist),i][t l(y,blist),j-1]+insert_cost(blist[j]) ].min

              if l(i,alist) == l(x,alist) and l(j,blist) == l(y,blist)
                d[i][j]=[ m,
                          fd[t l(x,alist),i-1][t l(y,blist),j-1]+edit_cost(alist[i],blist[j]) ].min
                fd[t l(x,alist),i ][t l(y,blist),j ] = d[i][j]
              else
                fd[t l(x,alist),i ][t l(y,blist),j ] = [ m,fd[ t l(x,alist),l(i,alist)-1 ][t l(y,blist),l(j,blist)-1 ]+d[i][j] ].min
              end
            end
          end
        end
      end

      #@d =d
      #@fd=fd
      return d[atree.size-1][btree.size-1]
    end

    def find_co_nodes(atree,btree)
      nodelist=[atree]
      nodelist.each{|node|
        node.children.each{|anode|
          i = btree.to_a.index {|bnode| bnode.name == anode.name }
          nodelist << anode unless i.nil?
        }
      }
      nodelist.delete(atree) unless atree.name == btree.name
      return nodelist
    end

    def make_profile(trees)
      result = Array.new
      parameter = {
        :ndc_layer1 => 1.0,
        :ndc_layer2 => 2.0,
        :ndc_layer3 => 1.0,
        :comment_weight => 0.0
      }

      max_dist = 0
      # すべてのツリーの組み合わせに対して類似度を計算
      trees.each{|atree|
        next if atree.content["count"]==0
        trees.each{|btree|
          next if atree.name == btree.name or btree.content["count"]==0

          # 編集距離・共通ラベルの計算
          distance = self.edit_distance(atree,btree)
          co_nodes = self.find_co_nodes(atree,btree).map{|node| node.name}
          max_dist = distance if max_dist < distance
          #comment_rate = btree.content["comment_rate"]

          co_nodes_score = co_nodes.map{|label|
            case label
	      when /^\d\*\*/
                parameter[:ndc_layer1]
              when /^\d\d\*/
                parameter[:ndc_layer2]
              when /^\d\d\d/
                parameter[:ndc_layer3]
            end
          }.sum

          result<< {
            :atree          => atree.name,
            :btree          => btree.name,
            :distance       => distance,
            #:comment_rate   => comment_rate,
            :co_nodes       => co_nodes,
            :co_nodes_score => co_nodes_score,
          }
        }
      }

      max_sim = 0
      result.each{|r|
        r[:distance] = (max_dist-r[:distance])/max_dist.to_f

        c = r[:co_nodes_score]
        d = r[:distance]
        #cr = (1 + (r[:comment_rate] * parameter[:comment_weight]))

        r[:sim] = c * d# * cr
        max_sim = r[:sim] if max_sim < r[:sim]
      }
      result.each{|r| r[:sim] = r[:sim] / max_sim.to_f;r[:sim]=0.0 if r[:sim].nan? }

      self.ranking(result)
    end

    def ranking(result)
      result.sort!{|a,b|
        if a[:atree]==b[:atree]
          a[:sim] <=> b[:sim]
        else
          a[:atree] <=> b[:atree]
        end
      }.reverse!
      hash=Hash.new
      result.each{|r|
        hash[r[:atree]]=Array.new if hash[r[:atree]].nil?
        hash[r[:atree]]<< r
      }
      hash
    end
  end
end
