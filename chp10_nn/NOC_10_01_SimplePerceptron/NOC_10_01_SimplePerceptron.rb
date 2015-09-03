# The Nature of Code
# http://natureofcode.com
# Simple Perceptron Example
# See: http://en.wikipedia.org/wiki/Perceptron

class Perceptron
  attr_reader :weights

  # Perceptron is created with n weights and a learning constant
  def initialize(n, c)
    @weights = Array.new(n) { rand(-1.0..1) }
    @c = c # learning constant
  end

  # Function to train the Perceptron
  # Weights are adjusted based on "desired" answer
  def train(inputs, desired)
    # Guess the result
    guess = feedforward(inputs)
    # Compute the factor for changing the weight based on the error
    # Error = desired output - guessed output
    # Note this can only be 0, -2, or 2
    # Multiply by learning constant
    error = desired - guess
    # Adjust weights based on weightChange * input
    @weights.collect!.with_index { |w, i| w + error * inputs[i] }
  end

  # Guess -1 or 1 based on input values
  def feedforward(inputs)
    # Sum all values
    sum = @weights.zip(inputs).map { |a, b| a * b }.inject(0, :+)
    # Result is sign of the sum, -1 or 1
    activate(sum)
  end

  def activate(sum)
    sum > 0 ? 1 : -1
  end
end

# A class to describe a training point
# Has an x and y, a "bias" (1) and a known output
# Could also add a variable for "guess" but not required here
class Trainer
  attr_reader :inputs, :answer

  def initialize(x, y, a)
    @inputs = [x, y, 1]
    @answer = a
  end
end

# Code based on text "Artificial Intelligence", George Luger

# The function to describe a line
def f(x)
  0.4 * x + 1
end

def setup
  sketch_title 'Noc 10 01 Simple Perceptron'
  # Coordinate space
  @xmin = -400
  @ymin = -100
  @xmax =  400
  @ymax =  100
  @count = 0
  # The perceptron has 3 inputs -- x, y, and bias
  # Second value is "Learning Constant"
  # Learning Constant is low and is necessarily not optimal
  @ptron = Perceptron.new 3, 0.00001
  # Create a rand set of training points and calculate the "known" answer
  @training = Array.new(2_000) do
    x = rand(@xmin..@xmax)
    y = rand(@ymin..@ymax)
    answer = y < f(x) ? -1 : 1
    Trainer.new(x, y, answer)
  end
end

def draw
  background(255)
  translate(width / 2, height / 2)
  # Draw the line
  stroke_weight(4)
  stroke(127)
  x1 = @xmin
  y1 = f(x1)
  x2 = @xmax
  y2 = f(x2)
  line(x1, y1, x2, y2)
  # Draw the line based on the current weights
  # Formula is weights[0]*x + weights[1]*y + weights[2] = 0
  stroke(0)
  stroke_weight(1)
  weights = @ptron.weights
  x1 = @xmin
  y1 = (-weights[2] - weights[0] * x1) / weights[1]
  x2 = @xmax
  y2 = (-weights[2] - weights[0] * x2) / weights[1]
  line(x1, y1, x2, y2)
  # Train the Perceptron with one "training" point at a time
  @ptron.train(@training[@count].inputs, @training[@count].answer)
  @count = (@count + 1) % @training.size
  # Draw all the points based on what the Perceptron would "guess"
  # Does not use the "known" correct answer
  @count.times do |i|
    stroke(0)
    stroke_weight(1)
    fill(0)
    train = @training[i]
    guess = @ptron.feedforward(train.inputs)
    no_fill if guess > 0
    ellipse(train.inputs[0], train.inputs[1], 8, 8)
  end
end

def settings
  size 640, 360
  smooth 4
end
