class Field
    def to_s
        "-"
    end
end

class Leaf < Field

    def initialize
        @in_group = false
    end

    def to_s
        "L"
    end
end

class Ant
    
    def initialize(x, y)
        @x = x
        @y= y
        @hasLeaf = nil
    end

    def to_s
        @hasLeaf.nil? ? "A*" : "A" 
    end
end

# a = Ant.new([])
# a.take_leaf
# if a.get_has_leaf 
#     puts "ant has a leaf"
# else
#     puts "somethig is not yes"
# end