#
# The Nature of Code
# NOC_9_03_SmartRockets
# Pathfinding w/ Genetic Algorithms
# DNA is an array of vectors

# Each Rocket's DNA is an array of PVectors
# Each Vec2D acts as a force for each frame of animation
# Imagine an booster on the end of the rocket that can point in any direction
# and fire at any strength every frame

# The Rocket's fitness is a function of how close it gets to the target as well as how fast it gets there

# This example is inspired by Jer Thorp's Smart Rockets
# http://www.blprnt.com/smartrockets/
%w[dna obstacle population rocket].each do |klass|
  require_relative klass
end

def setup
  sketch_title 'Noc 9 03 Smart Rockets'
  # The number of cycles we will allow a generation to live
  @lifetime = 300
  # Initialize variables
  @lifecycle = 0
  @recordtime = @lifetime
  @target = Obstacle.new(width / 2 - 12, 24, 24, 24)
  # Create a population with a mutation rate, and population max
  @mutation_rate = 0.01
  @population = Population.new(@mutation_rate, 50, width, height)
  # Create the obstacle course
  @obstacles = []
  @obstacles << Obstacle.new(width / 2 - 100, height / 2, 200, 10)
end

def draw
  background(255)
  # Draw the start and target locations
  @target.display
  # If the generation hasn't ended yet
  if @lifecycle < @lifetime
    @population.live(@obstacles, @target)
    @recordtime = @lifecycle if @population.target_reached && @lifecycle < @recordtime
    @lifecycle += 1
  else # Otherwise a new generation
    @lifecycle = 0
    @population.fitness
    @population.selection
    @population.reproduction
  end
  # Draw the obstacles
  @obstacles.each(&:display)
  # Display some info
  fill(0)
  text("Generation #: #{@population.generations}", 10, 18)
  text("Cycles left: #{@lifetime - @lifecycle}", 10, 36)
  text("Record cycles: #{@recordtime}", 10, 54)
end

# Move the target if the mouse is pressed
# System will adapt to new target
def mouse_pressed
  @target.location.x = mouse_x
  @target.location.y = mouse_y
  @recordtime = @lifetime
end

def settings
  size(640, 360)
end
