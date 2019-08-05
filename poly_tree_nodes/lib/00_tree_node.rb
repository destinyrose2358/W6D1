class PolyTreeNode
    attr_reader :children, :value, :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        parent.children.delete(self) unless parent.nil?
        @parent = parent_node
        parent_node.children << self unless parent_node.nil? || parent_node.children.include?(self)
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Not a child" unless @children.include?(child_node)
        child_node.parent = nil
    end
 
    def dfs(target_value)
        return self if self.value == target_value
        children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            current_node = queue.shift
            if current_node.value == target_value
                return current_node
            else
                queue.push(*current_node.children)
            end
        end
        nil 
    end


end

