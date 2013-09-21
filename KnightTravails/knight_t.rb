class KPF
  def initialize(start_pos)
    @start_pos = start_pos
    @tree = build_move_tree
  end

  def build_move_tree
    root = TreeNode.new(@start_pos)

    visited = []
    to_visit = [root]
    to_visit.each do |one_node|

      visited << one_node

      all_new_moves = KPF.new_move_positions(one_node.value)

      all_new_moves.each do |new_move|
        new_node = TreeNode.new(new_move, one_node)
        unless visited.include?(new_node) or to_visit.include?(new_node)
          one_node.children << new_node
          to_visit << new_node
        end
      end
    end
    visited
  end



  def self.new_move_positions(pos_right_now)
    new_positions = []
    moves = [[1,2],[1,-2],[-1,2],[-1,-2],
            [2,1],[2,-1],[-2,1],[-2,-1]]

    moves.each do |move|
      temp_pos = [pos_right_now[0] + move[0],
                pos_right_now[1] + move[1]]

      unless temp_pos[0] > 8 || temp_pos[1] > 8
        new_positions << temp_pos unless temp_pos.to_s.include?("-")
      end
    end
    new_positions
  end

  def find_path(target_pos)
    nodes = []
    nodes << @tree[0]
    until nodes.empty?
      node = nodes.shift
      if node.value == target_pos
        return node
      else
        node.children.each {|child| nodes << child}
      end
    end
  end
end

class TreeNode
  attr_accessor :children, :parent, :value

  def to_s
    "#{value}: children #{children.map(&:value)}\n"

  end

  def initialize(value, parent=nil)
    @value = value
    @children = []
    @parent = parent
  end

  def ==(other)
    return @value == other.value
  end

  def set_parent(parent)
    @parent = parent
    if !self.parent.children.include?(self)
      self.parent.children << self
    end
  end

  def path
    return [self.value] if self.parent.nil?
    self.parent.path << self.value
  end
end

if __FILE__ == $PROGRAM_NAME

  knight = KPF.new([0, 0])
  # KPF.new_move_positions([1,2])
  knight.build_move_tree
  p knight.find_path([8, 3]).path
end

