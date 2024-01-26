class PolyTreeNode
    attr_reader :value,:parent,:children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end
 # node3.parent=
    def parent=(new_parent)
        if new_parent == nil
            parent.children.delete(self)
            @parent = new_parent
        else 
            if parent == nil
                @parent = new_parent
                new_parent.children << self
            else 
                parent.children.delete(self)
                @parent = new_parent
                new_parent.children << self
            end
        end

    end
    # node2 = self . add child (new)
    def add_child(new_child)
        new_child.parent = self
    end
    
    def remove_child(child)
        if self.children.include?(child)
            child.parent = nil
        else
            raise "#{child.value} was not a child of #{self.value}"
        end 
    end
    
    def dfs(target)
        return self if self.value == target

        self.children.each do |child|
            search = child.dfs(target)
            return search unless search.nil?
        end
        return nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty?
            current_node = queue.shift
            return current_node if current_node.value == target

            queue += current_node.children
        end
        return nil
    end
end