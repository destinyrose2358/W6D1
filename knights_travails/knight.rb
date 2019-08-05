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
        #debugger
        possible_moves = KnightPathFinder.valid_moves(pos)
        true_moves = possible_moves.reject { |position| considered_positions.include?(position) }
        self.considered_positions += true_moves
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

    def find_path(end_pos)
        target_move_node = root_node.bfs(end_pos)
        trace_path_back(target_move_node)
    end

    def trace_path_back(end_node)
        current_node = end_node
        move_set = []
        until current_node.parent.nil?
            move_set.unshift(current_node.value)
            current_node = current_node.parent
        end
        move_set.unshift(current_node.value)
    end


end