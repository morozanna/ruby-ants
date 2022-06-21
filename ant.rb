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
    attr_accessor :x, :y, :carrying

    def initialize(x, y)
        @x = x
        @y= y
        @carrying = nil
    end

    def to_s
        @carrying.nil? ? "A" : "a" 
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
    return qty
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

def get_move_coord(init_x, init_y, direction)
    if direction == 1:
        return init_x, init_y - 1
    if direction == 2:
        return init_x + 1, init_y
    if direction == 3:
        return init_x, init_y + 1
    if direction == 4:
        return init_x - 1, init_y
end

def is_on_board(x, y, board)
    length = board.length()
    width = board[0].length()

    return x >= 0 and y >= 0 and x < length and y < width 
end

def add_to_group(board, leaf_x, leaf_y, excluded)
    return unless board[leaf_y][leaf_x].instance_of? Leaf
    board[leaf_y][leaf_x].in_group = true
    excluded.append(board[leaf_y][leaf_x])
    for i in 0..3 do
        neigh_x, neigh_y = get_move_coord(leaf_x, leaf_y, i)
        if excluded.include? board[neigh_y][neigh_x] or !is_on_board(neigh_x, neigh_y) or !board[neigh_y][neigh_x].instance_of? Leaf
            next
        end
        add_to_group(board, neigh_x, neigh_y, excluded)
    end

end

def do_step(board, ants)
    ants.each do |ant|
        #picking up a leaf
        if board[ant.y][ant.x].instance_of? Leaf and !board[ant.y][ant.x].in_group
            leaf = board[ant.y][ant.x]
            board[ant.y][ant.x] = Field.new()
            ant.carrying = leaf
            next
        end
        #dropping a leaf
        unless board[ant.y][ant.x].instance_of? Leaf and ant.carrying.nil?
            found_leaf = false
            for i in 1..4 do
                leaf_x, leaf_y = get_move_coord(ant.x, ant.y, i)
                if is_on_board(leaf_x, leaf_y, board) and board[leaf_y[leaf_x]].instance_of? Leaf
                    found_leaf = true
                    board[ant.y][ant.x] = ant.carrying
                    ant.carrying = nil
                end
            end
            if found_leaf:
                next
            end
        end
        #just move
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
leaves_qty = create_leaves(board, length, width)
puts "Leaves and Ants before: "
print_boards(board, ants)
step = 0
while true
    leaves = []
    board.each do |row|
        row.each do |f|
            if f.instance_of? Leaf
                leaves.append(f.in_group)
            end
        end
    end
    if leaves.all? and leaves.length() == leaves_qty
        break
    end
    do_step(board, ants)
end
