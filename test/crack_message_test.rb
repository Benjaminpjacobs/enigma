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
  # def test_it_can_parse_and_split
  #   c = CrackMessage.new(@encrypted_string, @date)
  #   c.parse_and_split_message
  #   expected = [["y", "5", "V", "*"],
  #               ["m", "7", "H", "g"],
  #               ["K", "Z", "H", "#"],
  #               ["p", "Z", ";"]]
  #   assert_equal expected, c.to_crack.message
  # end

  # def test_find_last_group_of_four
  #   c = CrackMessage.new(@encrypted_string, @date)
  #   c.parse_and_split_message
  #   assert_equal ["K", "Z", "H", "#"] , c.last_group_of_four
  # end

  # def test_find_comparison_index
  #   c = CrackMessage.new(@encrypted_string, @date)
  #   c.parse_and_split_message
  #   assert_equal [37, 37, 4, 13], c.comparison_index
  # end

  # def test_find_character_index
  #   c = CrackMessage.new(@encrypted_string, @date)
  #   c.parse_and_split_message
  #   assert_equal [49, 64, 46, 67], c.find_character_indexes
  # end

  # def test_find_rotations
  #   c = CrackMessage.new(@encrypted_string, @date)
  #   c.parse_and_split_message
  #   assert_equal [12, 27, 42, 54], c.find_rotations
  # end
end
