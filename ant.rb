class Ant
    
    def initialize(curr_position)
        @curr_position = curr_position
        @last_position = []
        @hasLeaf = false
        @break = 0
    end
    
    def set_position(new_position)
        @last_position = @curr_position
        @curr_position = new_position
    end

    def take_leaf()
        @hasLeaf = true
        @break = 5
    end

    def leave_leaf()
        @hasLeaf = false
        @break = 5
    end

    def move(new_position)
        @last_position = @curr_position
        @curr_position = new_position
        @break -= 1
    end

    def get_curr_position()
        @curr_position
    end

    def get_last_position()
        @last_position
    end

    def get_has_leaf()
        @hasLeaf
    end

    def get_break()
        @break
    end
end
