require "minitest/autorun"
require "minitest/pride"
require "./lib/crack_message.rb"

class CrackMessageTest < Minitest::Test
  def test_it_exists
    c = CrackMessage.new
    assert_instance_of CrackMessage, c
  end
  def test_it_can_create_message_object
    c = CrackMessage.new
    actual = c.instantiate_message("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    assert_instance_of Message, c.to_crack
  end
  def test_it_can_parse_and_split
    c = CrackMessage.new
    c.instantiate_message("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [["y", "5", "V", "*"], ["m", "7", "H", "g"], ["K", "Z", "H", "#"], ["p", "Z", ";"]] ,    c.to_crack.message
  end
  def test_find_last_group_of_four
    c = CrackMessage.new
    c.instantiate_message("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal ["K", "Z", "H", "#"] , c.last_group_of_four
  end
  def test_find_comparison_index
    c = CrackMessage.new
    c.instantiate_message("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [37, 37, 4, 13] , c.comparison_index
  end
  def test_find_character_index
    c = CrackMessage.new
    c.instantiate_message("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [49, 64, 46, 67], c.find_character_indexes
  end
  def test_find_rotations
    c = CrackMessage.new
    c.instantiate_message("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    c.parse_and_split_message
    assert_equal [12, 27, 42, 54], c.find_rotations
  end
  def test_crack
    c = CrackMessage.new
    c.instantiate_message("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    assert_equal "Message: message ..end... Cracked with key: 12345 and date: 2017-03-28" , c.crack
  end
end
