require_relative 'test_helper'
require 'java'
require_relative '../xor'


class NetworkTest < Minitest::Test

 def test_new
    network = Network.new(10, 10)
    assert_equal 11, network.hidden.length
  end
end
