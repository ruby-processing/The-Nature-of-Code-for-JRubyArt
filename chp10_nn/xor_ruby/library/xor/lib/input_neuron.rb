class InputNeuron < Neuron
  attr_reader :output
  def input(data)
    @output = data
  end
end
