require './test/test_helper'
require "./lib/crack_message.rb"

class CrackMessageTest < Minitest::Test

  def setup
    @encrypted_string = "y5V*m7HgKZH#pZ;"
    @date = Date.new(2017, 03, 28)
  end

  def test_it_exists
    c = CrackMessage.new(@encrypted_string, @date)
    assert_instance_of CrackMessage, c
  end

  def test_crack
    c = CrackMessage.new(@encrypted_string, @date)
    expected = "Message cracked with key: 12345 and date: 2017-03-28"
    assert_equal expected, c.crack
  end

  def test_crack_with_leading_zeros
    c = CrackMessage.new("3lsLHm2$w2HL3vsGqBI%orn%I", @date)
    expected = "Message cracked with key: 01802 and date: 2017-03-28"
    assert_equal expected, c.crack
  end
end