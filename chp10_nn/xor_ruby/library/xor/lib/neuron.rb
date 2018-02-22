# Generic Neuron Class
# Can be a bias neuron (true or false)
class Neuron
  attr_reader :output, :connections, :bias

  def initialize(output = 0)
    @connections = []
    @output = output
    @bias = !output.zero?
  end

  def add_connection(c)
    connections << c
  end

  def calc_output
    return if bias #  do nothing
    sigmoid = ->(x) { 1.0 / (1.0 + Math.exp(-x)) }
    sum = 0
    bias_value = 0
    # fstring = 'Looking through %d connections'
    # puts(format(fstring, connections.size))
    connections.each do |c|
      from = c.from
      to = c.to
      #  Is this connection moving forward to us
      #  Ignore connections that we send our output to
      if to == self
        #  This isn't really necessary
        #  Ttreating the bias individually in case needed to at some point
        if from.bias
          bias_value = from.output * c.weight
        else
          sum += from.output * c.weight
        end
      end
    end
    #  Output is result of sigmoid function
    @output = sigmoid.call(bias_value + sum)
  end
end
