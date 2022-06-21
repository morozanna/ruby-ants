class Field
    def to_s
        "-"
    end
end

class Leaf < Field
    attr_accessor :in_group
    
    def initialize
        @in_group = false
    end

    def to_s
        "L"
    end
end

class Ant
    attr_accessor :x, :y, :hasLeaf

    def initialize(x, y)
        @x = x
        @y= y
        @hasLeaf = nil
    end

    def to_s
        @hasLeaf.nil? ? "A" : "a" 
    end
end

def create_board(x, y)
    return new_board = Array.new(x) {Array.new(y, "-")}
end

def create_ants(x, y)
    ants_qty = (x * y * 0.4).ceil
    new_ants_coord = Array.new(ants_qty)
    for i in 1..ants_qty do
        loop do
            rand_x = rand(0..x-1)
            rand_y = rand(0..y-1)
            unless new_ants_coord.include? [rand_x, rand_y]
                new_ants_coord[i-1] = [rand_x, rand_y] 
                break
            end
        end
    end
    new_ants = []
    for coord in new_ants_coord
        a = Ant.new(coord[0], coord[1])
        new_ants.append(a)
    end
    return new_ants
end

def create_leaves(board, x, y)
    qty = (x * y * 0.6).ceil
    new_leaves_coord = Array.new(qty)
    for i in 1..qty do
        loop do
            rand_x = rand(0..x-1)
            rand_y = rand(0..y-1)
            unless new_leaves_coord.include? [rand_x, rand_y]
                new_leaves_coord[i-1] = [rand_x, rand_y] 
                break
            end
        end
    end
    for coord in new_leaves_coord
        board[coord[0]][coord[1]] = Leaf.new() 
    end
end

def print_boards(board, ants)
    for y in 0..board.length()-1 do
        for x in 0..board[0].length()-1 do
            ant = []
            ants.each do |a|
                if a.x == x and a.y == y
                    ant.append(a)
                end
            end
            ant = ant.length() > 0 ? ant[0] : nil
            if ant.nil?
                print board[y][x].to_s
            else
                print ant.to_s
            end
        end
        print "\t"
        for x in 0..board[0].length() do
            print board[y][x].to_s
        end
        print "\n"
    end
end

# getting board size
length = 5
width = 5
loop do
    puts "Enter board length (default value is 5)"
    value = gets.to_i
    if value > 1 and value < 10
        length = value
        break
    elsif value == 0
        puts "Selected default length = 5"
        break
    else
        puts "Enter correct length (larger than 1 and lesser than 10)"
    end
end
loop do
    puts "Enter board width (default value is 5)"
    value2 = gets.to_i
    if value2 > 1 and value2 < 10
        width = value2
        break
    elsif value2 == 0
        puts "Selected default width = 5"
        break
    else
        puts "Enter correct width (larger than 1 and lesser than 10)"
    end
end
board = create_board(length, width)
ants = create_ants(length, width)
create_leaves(board, length, width)
puts "Leaves and Ants before: "
print_boards(board, ants)


# a = Ant.new([])
# a.take_leaf
# if a.get_has_leaf 
#     puts "ant has a leaf"
# else
#     puts "somethig is not yes"
# end