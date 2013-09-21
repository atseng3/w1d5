# require 'debugger'
class TreeNode
  attr_accessor :children, :parent, :value

  # def to_s
  #   value
  # end

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def set_parent(parent)
    #if self.parent.children.nil?
      @parent = parent
      if !self.parent.children.include?(self)
        self.parent.children << self
      end
  end
end

# if __FILE__ == $PROGRAM_NAME

  # n1 = TreeNode.new(1)
#   n2 = TreeNode.new(2)
#   n3 = TreeNode.new(3)
#   n4 = TreeNode.new(4)
#   n5 = TreeNode.new(5)
#   n6 = TreeNode.new(6)
#
#   n2.set_parent(n1)
#   n4.set_parent(n2)
#   n3.set_parent(n1)
#   n5.set_parent(n3)
#   n6.set_parent(n3)
#   p n6
#   p n4
#   p n2
# end