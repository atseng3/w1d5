require 'debugger'

class BinaryTreeNode
  attr_accessor :left_child, :right_child, :parent, :value

  def to_s
    "N#{value}"
  end

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
    @parent = nil
  end

  def set_parent(parent, side = 'left')
    if side == 'left'
      unless parent.left_child.nil?
        parent.left_child.parent = nil
      end
      @parent = parent
      parent.left_child = self
    elsif side == 'right'
      unless parent.right_child.nil?
        parent.right_child.parent = nil
      end
      @parent = parent
      parent.right_child = self
    end
  end

  def dfs(value=nil, &blk)
    if block_given?
      return self if blk.call(self.value)
    else
      return self if self.value == value
    end
    left = self.left_child
    right = self.right_child# .dfs(value)

    if !left.nil?
      left = self.left_child.dfs(value, &blk)
    end

    if !right.nil?
      right = self.right_child.dfs(value, &blk)
    end

    return left || right
  end

  def bfs(value1)
    nodes = []
    nodes << self
    until nodes.empty?
      node = nodes.shift
      next if node.nil?
      if node.value == value1
        return node
      else
        nodes << node.left_child << node.right_child
      end
    end
  end
end


if __FILE__ == $PROGRAM_NAME

  pos1 = BinaryTreeNode.new([1,2])
  pos1.set_parent(previous_pos)

  n1 = BinaryTreeNode.new(1)
  n2 = BinaryTreeNode.new(2)
  n3 = BinaryTreeNode.new(3)
  n4 = BinaryTreeNode.new(4)
  n5 = BinaryTreeNode.new(5)
  n6 = BinaryTreeNode.new(6)

  n2.set_parent(n1, 'left')
  n4.set_parent(n2, 'left')
  n3.set_parent(n1, 'right')
  n5.set_parent(n3, 'left')
  n6.set_parent(n3, 'right')

  p n1.dfs(6)
  p n1.dfs() {|n| n == 6}
end