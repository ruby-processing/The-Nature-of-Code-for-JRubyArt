# The Nature of Code
# NOC_7_02_GameOfLifeSimple
class GOL
  def initialize(width, height)
    @w = 8
    @rows,  @cols = height / @w, width / @w
    puts "rows: #{@rows} - @cols #{@cols}"
    init
  end

  def init
    @board = Array.new(@cols) do
      Array.new(@rows) { rand(2).to_i }
    end
  end

  def generate
    nextgen = Array.new(@cols) { Array.new(@rows) { 0 } }
    (1 ... @cols - 1).each do |x|
      (1 ... @rows - 1).each do |y|
        neighbors = 0
        (-1 .. 1).each do |i|
          (-1 .. 1).each do |j|
            if @board[x + i][y + j] == nil
              puts "x+i #{x + i} - y+j #{y + j}"
            end
            neighbors += @board[x + i][y + j] if @board[x + i][y + j]
          end
        end
        # A little trick to subtract the current cell's state since
        # we added it in the loop above
        neighbors -= @board[x][y]
        # rules of life
        if @board[x][y] == 1 && neighbors <  2
          nextgen[x][y] = 0            # Loneliness
        elsif @board[x][y] == 1 && neighbors >  3
          nextgen[x][y] = 0            # Overpopulation
        elsif @board[x][y] == 0 && neighbors == 3
          nextgen[x][y] = 1            # Reproduction
        else
          nextgen[x][y] = @board[x][y] # Stasis
        end
      end
    end
    @board = nextgen
  end

  def display
    (0...@cols).each do |i|
      (0...@rows).each do |j|
        if @board[i][j] == 0
          fill(120)
        else
          fill(255)
        end
        stroke(0)
        rect(i * @w, j * @w, @w, @w)
      end
    end
  end
end

def setup
  sketch_title 'Noc 7 02 Game Of Life Simple'
  frame_rate(24)
  @gol = GOL.new(width, height)
end

def draw
  background(255)
  @gol.generate
  @gol.display
end

# reset board when mouse is pressed
def mouse_pressed
  @gol.init
end

def settings
  size(400, 400)
end

