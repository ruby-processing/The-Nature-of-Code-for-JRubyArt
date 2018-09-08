# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# Smart Rockets w/ Genetic Algorithms

# Each Rocket's DNA is an array of PVectors
# Each PVector acts as a force for each frame of animation
# Imagine an booster on the end of the rocket that can point in any direction
# and fire at any strength every frame.  The Rocket's fitness is a function of
# how close it gets to the target as well as how fast it gets there
# This example is inspired by Jer Thorp's Smart Rockets
# http://www.blprnt.com/smartrockets/
require_relative 'population'
require_relative 'dna'
require_relative 'rocket'

attr_reader :lifetime, :population, :life_counter, :target, :mutation_rate

def setup
  sketch_title 'Smart Rocket Basic'
  # The number of cycles we will allow a generation to live
  @lifetime = height
  # Initialize variables
  @life_counter = 0
  @target = Vec2D.new(width / 2, 24)
  # Create a population with a mutation rate, and population max
  @mutation_rate = 0.01
  @population = Population.new(mutation_rate, 50, width, height, target)
end

def draw
  background(255)
  # Draw the start and target locations
  fill(0)
  ellipse(target.x, target.y, 24, 24)
  # If the generation hasn't ended yet
  if life_counter < lifetime
    population.live
    @life_counter += 1
    # Otherwise a new generation
  else
    @life_counter = 0
    population.fitness
    population.selection
    population.reproduction
  end
  # Display some info
  fill(0)
  text(format('Generation #: %d', population.generations), 10, 18)
  text(format('Cycles left: %d', lifetime - life_counter), 10, 36)
end

# Move the target if the mouse is pressed
# System will adapt to new target
def mouse_pressed
  target.x = mouse_x
  target.y = mouse_y
end

def settings
  size(640, 360)
end

