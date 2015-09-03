# The Nature of Code
# NOC_7_01_WolframCA_simple
class CA
  attr_reader :w, :generation
  def initialize(width)
    @w = 10
    @cells = Array.new(width / @w) { 0 }
    @cells[@cells.size / 2] = 1
    @ruleset = [0, 1, 0, 1, 1, 0, 1, 0]
    @generation = 0
  end

  def generate
    nextgen = Array.new(@cells.size)
    (1 ... @cells.size - 1).each do |i|
      left = @cells[i - 1]
      me = @cells[i]
      right = @cells[i + 1]
      nextgen[i] = rules(left, me, right)
    end
    @cells = nextgen
    @generation += 1
  end

  def rules(a, b, c)
    idx = (a.to_s + b.to_s + c.to_s).to_i(2)
    @ruleset[7 - idx]
  end

  def display
    @cells.each_index do |i|
      if @cells[i] == 1
        fill(0)
      else
        fill(255)
      end
      no_stroke
      rect(i * w, generation * w, w, w)
    end
  end
end

def setup
  sketch_title 'Wolfram CA Simple'
  background(255)
  @ca = CA.new(width)
end

def draw
  @ca.display
  @ca.generate if @ca.generation < height / @ca.w
end

def settings
  size(800, 400)
end
