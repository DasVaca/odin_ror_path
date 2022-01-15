require_relative 'bst.rb'

to_d = ->(x) {x.data}

t = Tree.new((Array.new(15) { rand(1..100)}))
t.pretty_print
p "Balanced? #{t.balanced?}"
p "Elements"
p "Preorder : #{t.preorder.map &to_d}"
p "Inorder  : #{t.inorder.map &to_d}"
p "Postorder: #{t.postorder.map &to_d}"

(Array.new(10) { rand(100..200)}).each {|x| t.insert(x)}
t.pretty_print
p "Balanced? #{t.balanced?}"
t.rebalance
t.pretty_print
p "Balanced? #{t.balanced?}"
p "Elements"
p "Preorder : #{t.preorder.map &to_d}"
p "Inorder  : #{t.inorder.map &to_d}"
p "Postorder: #{t.postorder.map &to_d}"
