require './test/test_helper'
require "./lib/crack_message.rb"

class CrackMessageTest < Minitest::Test
  def test_it_exists
    c = CrackMessage.new("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    assert_instance_of CrackMessage, c
  end
  def test_it_can_parse_and_split
    c = CrackMessage.new("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [["y", "5", "V", "*"], ["m", "7", "H", "g"], ["K", "Z", "H", "#"], ["p", "Z", ";"]] ,    c.to_crack.message
  end
  def test_find_last_group_of_four
    c = CrackMessage.new("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal ["K", "Z", "H", "#"] , c.last_group_of_four
  end
  def test_find_comparison_index
    c = CrackMessage.new("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [37, 37, 4, 13] , c.comparison_index
  end
  def test_find_character_index
    c = CrackMessage.new("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [49, 64, 46, 67], c.find_character_indexes
  end
  def test_find_rotations
   c = CrackMessage.new("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [12, 27, 42, 54], c.find_rotations
  end
  def test_crack
    c = CrackMessage.new("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    assert_equal "Message cracked with key: 12345 and date: 2017-03-28" , c.crack
  end
end
