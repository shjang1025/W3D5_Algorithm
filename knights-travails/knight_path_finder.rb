require_relative '../lib/tree_node.rb'
require 'byebug'
class KnightPathFinder #chess board max row/col index = 7,7
    MOVES = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
    attr_reader :root_node, :considered_positions

    def initialize(starting_pos)
       @root_node = PolyTreeNode.new(starting_pos) #<= value of node
       @considered_positions = [starting_pos]
    end

    def self.valid_moves(start_pos) #new positions from a given position
        x,y = start_pos
        valid_moves = []
        MOVES.each do |p_move|
            if x + p_move.first < 8 && x + p_move.first >= 0 && y + p_move.last < 8 && y + p_move.last >= 0
                valid_moves << [x + p_move.first, y + p_move.last]
            end
        end
        valid_moves
    end
    #available move positions that are not in the previous position. 
    def new_move_positions(another_starting_pos)
        all_new_moves = KnightPathFinder.valid_moves(another_starting_pos)

        selected = all_new_moves.select {|position| !@considered_positions.include?(position)}
        @considered_positions.push(*selected)
        return selected #a 2D array
    end
    #debugger   
    def build_move_tree # [ (all move 1 nodes), (all move 2 nodes), (...)]
        queue = [root_node] #queue contains instances of PolyTreeNode (can access .value)
        until queue.empty?
            current_node = queue.shift
              
            next_moves = new_move_positions(current_node.value).map {|ele| PolyTreeNode.new(ele) } #create new polytree nodes, usinv current PTN.value
            next_moves.each do |child_move|
                current_node.add_child(child_move)
                # p current_node.children
                queue << child_move
            end
            
        end
    end

    def find_path(end_pos)
        end_node = self.root_node.dfs(end_pos)
        self.trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        path = [end_node.value]
        current_node = end_node
        until current_node.parent.nil?
            path.unshift(current_node.parent.value)
            current_node = current_node.parent
        end
        path
    end

end

if __FILE__ == $PROGRAM_NAME
test = KnightPathFinder.new([0,0])
p test #is a node 
p test.build_move_tree
p test.considered_positions.length
p test.find_path([6,2])
# end_pos = test.find_path([6,2])
# p test.trace_path_back(end_pos)
end