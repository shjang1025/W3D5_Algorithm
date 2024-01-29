require_relative '../lib/tree_node.rb'
class KnightPathFinder #chess board max row/col index = 7,7
    MOVES = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
    def initialize(starting_pos)
       @root_node = PolyTreeNode.new(starting_pos) #<= value of node
       @considered_positions = [starting_pos]
    end

    def self.valid_moves(start_pos) #new positions from a given position
        x,y = start_pos
        valid_moves = []
        MOVES.each do |p_move|
            if x + p_move.first < 8 && y + p_move.last < 8
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
        return selected
    end
    

end

test = KnightPathFinder.new([2,4])
p test
p KnightPathFinder.valid_moves([2,4])
p test.new_move_positions([3,2])