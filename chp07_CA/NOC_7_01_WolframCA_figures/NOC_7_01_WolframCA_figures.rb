# The Nature of Code
# NOC_7_01_WolframCA_figures
class CA
  def initialize(r, width)
    @ruleset = r
    @scl = 20
    @cells = Array.new(width / @scl)
    @generation = 0
    restart
  end

  def restart
    @cells = Array.new(@cells.size) { 0 }
    @cells[@cells.size / 2] = 1
    @generation = 0
  end

  def randomize
    @ruleset = Array.new(@ruleset.size){ rand(2) }
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
    s = a.to_s + b.to_s + c.to_s
    @ruleset[s.to_i(2)]
  end

  def render
    @cells.each_index do |i|
      if @cells[i] == 1
        fill(0)
      else
        fill(255)
      end
      stroke(0)
      rect(i * @scl, @generation * @scl, @scl, @scl)
    end
  end

  def finished(height)
    @generation > height / @scl
  end
end

def setup
  sketch_title 'Noc 7 01 Wolfram Ca Figures'
  background(255)
  ruleset = [0, 1, 1, 1, 1, 0, 1, 1]
  @ca = CA.new(ruleset, width)
end

def draw
  @ca.render
  @ca.generate
  if @ca.finished(height)
    save_frame('rule222.png')
  end
end

def mouse_pressed
  background(255)
  @ca.randomize
  @ca.restart
end

def settings
  size(1800, 600)
end

