# The Nature of Code
# http://natureofcode.com
# NOC_8_09_LSystem
# NB: There are far more elegant ways of creating LSystems in ruby

class Turtle
  attr_writer :len, :todo
  def initialize(s, l, t)
    @todo = s
    @len = l
    @theta = t
  end

  def render
    stroke(0, 175)
    @todo.each_char do |c|
      if c == 'F' or c == 'G'
        line(0,0, @len, 0)
        translate(@len, 0)
      elsif c == '+'
        rotate(@theta)
      elsif c == '-'
        rotate(-@theta)
      elsif c == '['
        push_matrix
      elsif c == ']'
        pop_matrix
      end
    end
  end

  def change_len(percent)
    @len *= percent
  end
end

class Rule
  attr_reader :a, :b
  def initialize(a, b)
    @a = a
    @b = b
  end
end

class LSystem
  attr_reader :sentence, :generation
  def initialize(axiom, r)
    @sentence = axiom
    @ruleset = r
    @generation = 0
  end

  def generate
    nextgen = ''
    @sentence.each_char do |curr|
      replace = '' + curr
      @ruleset.each do |rule|
        a = rule.a
        if a == curr
          replace = rule.b
          break
        end
      end
      nextgen += replace
    end
    @sentence = nextgen
    @generation += 1
  end
end

def setup
  sketch_title 'Noc 8 09 L System'
  # Create an empty ruleset
  # @ruleset = []]
  # Fill with two rules (These are rules for the Sierpinksi Gasket Triangle)
  # @ruleset << Rule.new('F','F--F--F--G')
  # @ruleset << new Rule('G','GG')
  # Create LSystem with axiom and ruleset
  # @lsys = LSystem.new('F--F--F', @ruleset)
  # @turtle = Turtle.new(@lsys.sentence,width * 2,TWO_PI / 3)

  # @ruleset = []
  # @ruleset << Rule.new['F','FF+[+F-F-F]-[-F+F+F]')
  # @lsys = LSystem.new('F-F-F-F', @ruleset)
  # @turtle = Turtle.new(@lsys.sentence,width-1,PI/2)
  @ruleset = []
  @ruleset << Rule.new('F', 'FF+[+F-F-F]-[-F+F+F]')
  @lsys = LSystem.new('F', @ruleset)
  @turtle = Turtle.new(@lsys.sentence, height / 3, 25.radians)
  @counter = 0
end

def draw
  background(255)
  fill(0)
  #text('Click mouse to generate', 10, height-10)
  translate(width / 2, height)
  rotate(-PI / 2)
  @turtle.render
  no_loop
end

def mouse_pressed
  return if @counter >= 5
  push_matrix
  @lsys.generate
  @turtle.todo = @lsys.sentence
  @turtle.change_len(0.5)
  pop_matrix
  redraw
  @counter += 1
end

def settings
  size(600, 600)
end

