class PolyTreeNode
    attr_reader :value,:parent,:children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        if new_parent == nil
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
  
end