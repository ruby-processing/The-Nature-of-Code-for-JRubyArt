require_relative 'test_helper'
require 'java'
require_relative '../xor'


class NeuronTest < Minitest::Test

 def test_new_no_param
    neuron = Neuron.new
    assert !neuron.bias
    assert neuron.output.zero?
  end

  def test_newparam
     input = 1
     neuron = Neuron.new input
     assert neuron.bias
     assert_equal neuron.output, input
   end

   def test_add_connection
      to = Neuron.new 1
      from = Neuron.new 2
      to.add_connection(Connection.new(from, to))
      assert_equal to.connections.length, 1
    end
end
