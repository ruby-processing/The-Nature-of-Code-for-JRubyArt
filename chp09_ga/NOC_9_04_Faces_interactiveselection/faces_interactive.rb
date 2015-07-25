# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# Interactive Selection
# http://www.genarts.com/karl/papers/siggraph91.html
require_relative 'population'
require_relative 'face'
java_import 'java.awt.Rectangle'
attr_reader :population, :button

def setup
  sketch_title 'Faces Interactive'
  color_mode(RGB, 1.0)
  popmax = 10
  mutation_rate = 0.05
  # A pretty high mutation rate here, our population is rather small we need
  # to enforce variety. Create a population with a target phrase, mutation
  # rate, and population max
  @population = Population.new(mutation_rate, popmax)
  # A simple button class
  @button = Button.new(15, 150, 160, 20, 'evolve new generation')
end

def draw
  background(1.0)
  # Display the faces
  population.display
  population.rollover(mouse_x, mouse_y)
  # Display some text
  text_align(LEFT)
  fill(0)
  text(format('Generation #: %d', population.generations), 15, 190)
  # Display the button
  button.display
  button.rollover(mouse_x, mouse_y)
end

# If the button is clicked, evolve next generation

def mouse_pressed
  return unless button.clicked(mouse_x, mouse_y)
  population.selection
  population.reproduction
end

def mouse_released
  button.released
end

# Useful little button class
class Button
  attr_reader :r, :txt, :clicked_on, :rollover_on

  def initialize(x, y, w, h, s)
    @r = Rectangle.new(x, y, w, h)
    @txt = s
  end

  def display
    # Draw rectangle and text based on whether rollover or clicked
    rect_mode(CORNER)
    stroke(0)
    no_fill
    fill(0.5) if rollover_on
    fill(0) if clicked_on
    rect(r.x, r.y, r.width, r.height, 8, 8, 8, 8) # rounded rect radius 8
    b = 0
    b = 1 if clicked_on
    b = 0.2 if rollover_on
    fill(b)
    text_align(LEFT)
    text(txt, r.x + 10, r.y + 14)
  end

  # Methods to check rollover, clicked, or released (must be called from
  # appropriate. Places in draw, mousePressed, mouseReleased
  def rollover(mx, my)
    @rollover_on = r.contains(mx, my)
  end

  def clicked(mx, my)
    @clicked_on = true if r.contains(mx, my)
    clicked_on
  end

  def released
    @clicked_on = false
  end
end

def settings
  size(800, 200)
end

