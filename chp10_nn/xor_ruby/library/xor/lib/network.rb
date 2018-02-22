# Daniel Shiffman
# The Nature of Code, Fall 2006
# Neural Network
# Class to describe the entire network
# Arrays for input neurons, hidden neurons, and output neuron
# Need to update this so that it would work with an array out outputs
# Rather silly that I didn't do this initially
# Also need to build in a "Layer" class so that there can easily
# be more than one hidden layer
class Network
  LEARNING_CONSTANT = 0.5
  attr_reader :input, :hidden, :output
  # Only One output now to start!!! (i can do better, really. . .)
  # Constructor makes the entire network based on number of inputs & number of
  # neurons in hidden layer
  # Only One hidden layer!!!  (fix this dood)
  def initialize(inputs, hidden_total)
    @input = (0..inputs).map { InputNeuron.new } # Got to add a bias input
    @hidden = (0..hidden_total).map { Neuron.new } # same as regular Neuron
    # Make bias neurons
    input[inputs] = Neuron.new(1)
    hidden[hidden_total] = Neuron.new(1)
    # Make output neuron
    @output = Neuron.new # same as regular Neuron
    # Connect input layer to hidden layer
    input.each do |input1|
      (0...hidden.length).each do |j|
        # Create the object and put it in both neurons
        c = Connection.new input1, hidden[j]
        input1.add_connection(c)
        hidden[j].add_connection(c)
      end
    end
    # Connect the hidden layer to the output neuron
    hidden.each do |hidden1|
      c = Connection.new(hidden1, output)
      hidden1.add_connection(c)
      output.add_connection(c)
    end
  end

  def feed_forward(input_vals)
    # Feed the input with an array of inputs
    input_vals.each_with_index do |val, i|
      input[i].input(val)
    end

    # Have the hidden layer calculate its output
    (0...hidden.length).each do |i|
      hidden[i].calc_output
    end

    # Calculate the output of the output neuron
    output.calc_output

    # Return output
    output.output
  end

  def train(inputs, answer)
    result = feed_forward(inputs)
    # This is where the error correction all starts
    # Derivative of sigmoid output function * diff between known and guess
    delta_output = result * (1 - result) * (answer - result)
    # BACKPROPOGATION
    # This is easier b/c we just have one output
    # Apply Delta to connections between hidden and output
    connections = output.connections
    connections.each do |c|
      neuron = c.from
      loutput = neuron.output
      delta_weight = loutput * delta_output
      c.adjust_weight(LEARNING_CONSTANT * delta_weight)
    end

    # ADJUST HIDDEN WEIGHTS
    hidden.each do |hidden1|
      connections = hidden1.connections
      sum = 0
      # Sum output delta * hidden layer connections (just one output)
      connections.each do |c|
        # Is this a from hidden layer to next layer (output)?
        sum += c.weight * delta_output if c.from == hidden1
      end
      # Then adjust the weights coming in based:
      # Above sum * derivative of sigmoid output function for hidden neurons
      connections.each do |c|
        # Is this a from previous layer (input) to hidden layer?
        next unless c.to == hidden1
        loutput = hidden1.output
        delta_hidden = loutput * (1 - loutput) # Derivative of sigmoid(x)
        delta_hidden *= sum # Would sum for all outputs if more than one output
        neuron = c.from
        delta_weight = neuron.output * delta_hidden
        c.adjust_weight(LEARNING_CONSTANT * delta_weight)
      end
    end
    result
  end
end
