require_relative 'test_helper'
require 'java'
require_relative '../xor'


class NeuronTest < Minitest::Test

  def test_new_no_param
    neuron = InputNeuron.new
    assert !neuron.bias
    assert neuron.output.zero?
  end

  def test_newparam
    input = 1
    neuron = InputNeuron.new input
    assert neuron.bias
    assert_equal neuron.output, input
  end

  def test_input
    neuron = InputNeuron.new
    neuron.input 2
    assert_equal 2, neuron.output
  end
end
