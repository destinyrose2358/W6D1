require_relative "../poly_tree_nodes/lib/00_tree_node.rb"
require "byebug"
class KnightPathFinder

    attr_reader :root_node
    attr_accessor :considered_positions

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos) 
        @considered_positions = [pos]
    end

    def new_move_positions(pos)
        possible_moves = KnightPathFinder.valid_moves(pos)
        true_moves = possible_moves.reject { |position| considered_positions.include?(position)}
        considered_positions += true_moves
        true_moves
    end

    def self.valid_moves(pos)
        row,col = pos 
        possible_moves = [ [1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1] ]
        possible_moves.map! do |position|  
            move_row = position[0] + row 
            move_col = position[1] + col 
            [move_row,move_col]
        end
        possible_moves.select do |position|
            position[0].between?(0,7) && position[1].between?(0,7)
        end
    end

    def build_move_tree()
        queue = [root_node]
        until queue.empty?
            current_node = queue.shift 
            current_position = current_node.value
            new_move_options = new_move_positions(current_position)
            new_move_options.each do |position|
                new_move_node = PolyTreeNode.new(position)
                new_move_node.parent = current_node
                queue.push(new_move_node)
            end
        end
    end

    # def bfs(target_value)
    #     queue = [self]
    #     until queue.empty?
    #         current_node = queue.shift
    #         if current_node.value == target_value
    #             return current_node
    #         else
    #             queue.push(*current_node.children)
    #         end
    #     end
    #     nil 
    # end



end