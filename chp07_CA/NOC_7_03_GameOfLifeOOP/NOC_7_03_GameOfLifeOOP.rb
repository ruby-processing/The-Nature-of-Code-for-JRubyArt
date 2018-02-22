# The Nature of Code
# NOC_7_03_GameOfLifeOOP
class Cell
  attr_reader :previous, :state
  def initialize(x, y, w)
    @x, @y, @w = x, y, w
    @state = rand(2)
    @previous = @state
  end

  def save_previous
    @previous = @state
  end

  def new_state(s)
    @state = s
  end

  def display
    if @previous == 0 && @state == 1
      fill(0, 0, 255)
    elsif @state == 1
      fill(0)
    elsif @previous == 1 && @state == 0
      fill(255, 0, 0)
    else
      fill(255)
    end
    stroke(0)
    rect(@x, @y, @w, @w)
  end
end

class GOL
  def initialize(width, height)
    @w = 8
    @columns, @rows = width / @w, height / @w
    init
  end

  def init
    @board = Array.new(@columns) do |i|
      Array.new(@rows) do |j|
        Cell.new(i*@w, j*@w, @w)
      end
    end
  end

  def generate
    @board.each do |rows|
      rows.each(&:save_previous)
    end
    # Loop through every spot in our 2D array and check spots neighbors
    @board.each_index do |x|
      @board[x].each_index do |y|
        # Add up all the states in a 3x3 surrounding grid
        neighbors = 0
        (-1..1).each do |i|
          (-1..1).each do |j|
            neighbors += @board[(x + i + @columns) % @columns][(y + j + @rows) % @rows].previous
          end
        end
        # A little trick to subtract the current cell's state since
        # we added it in the above loop
        neighbors -= @board[x][y].previous
        # Rules of Life
        if @board[x][y].state == 1 && neighbors <  2
          @board[x][y].new_state(0)           # Loneliness
        elsif @board[x][y].state == 1 && neighbors >  3
          @board[x][y].new_state(0)           # Overpopulation
        elsif @board[x][y].state == 0 && neighbors == 3
          @board[x][y].new_state(1)           # Reproduction
        end
      end
    end
  end

  def display
    @board.each do |rows|
      rows.each(&:display)
    end
  end
end

def setup
  sketch_title 'Game Of Life OOP'
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
  size(640, 360)
end

