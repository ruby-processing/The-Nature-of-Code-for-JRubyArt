require_relative 'test_helper'
require 'java'
require_relative '../xor'

class ConnectionTest < Minitest::Test

 def test_new_from_to
    from = Neuron.new(1)
    to = Neuron.new(2)
    connection = Connection.new from, to
  end

  def test_new_from_to_weight
     from = Neuron.new(1)
     to = Neuron.new(2)
     connection = Connection.new from, to, rand(-1..1.0)
   end

   def test_adjust_weight
      from = Neuron.new(1)
      to = Neuron.new(2)
      connection = Connection.new from, to, 0.5
      connection.adjust_weight(0.2)
      assert_in_epsilon(0.7, connection.weight)
    end
end
