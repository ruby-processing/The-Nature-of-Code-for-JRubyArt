require_relative 'test_helper'
require_relative '../xor'


class NeuronTest < Minitest::Test
  attr_reader :neuron, :neuron_one, :neuron_two

  def setup
    @neuron = Neuron.new
    @neuron_one = Neuron.new 1
    @neuron_two = Neuron.new 2
  end

  def test_new_no_param
    assert !neuron.bias
    assert neuron.output.zero?
  end

  def test_newparam
    input = 1
    assert neuron_one.bias
    assert_equal neuron_one.output, input
  end

  def test_add_connection
    to = neuron_one
    from = neuron_two
    to.add_connection(Connection.new(from, to))
    assert_equal to.connections.length, 1
  end

  def test_calc_output
    puts neuron.output
    puts neuron_one.output
    puts neuron_two.output
  end
end
