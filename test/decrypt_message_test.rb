require "minitest/autorun"
require "minitest/pride"
require "./lib/decrypt_message.rb"

class DecryptMessageTest < Minitest::Test
  def test_it_exists
    d = DecryptMessage.new("y5V*m7HgKZH#pZ;", 12345, Date.new(2017, 03, 28))
    assert_instance_of DecryptMessage, d
  end
  def test_it_can_get_offset
    d = DecryptMessage.new("y5V*m7HgKZH#pZ;", 12345, Date.new(2017, 03, 28))
    d.get_offset
    assert_equal [0,4,8,9], d.to_decrypt.offset
  end
  def test_it_can_get_rotations
    d = DecryptMessage.new("y5V*m7HgKZH#pZ;", 12345, Date.new(2017, 03, 28))
    d.get_offset
    d.get_rotations
    assert_equal [12, 23, 34, 45], d.to_decrypt.rotation
  end
  def test_it_can_parse_and_split
    d = DecryptMessage.new("y5V*m7HgKZH#pZ;", 12345, Date.new(2017, 03, 28))
    d.parse_and_split_message
    assert_equal [["y", "5", "V", "*"], ["m", "7", "H", "g"], ["K", "Z", "H", "#"], ["p", "Z", ";"]] , d.to_decrypt.message
  end
  def test_it_can_decrypt_message
    d = DecryptMessage.new("y5V*m7HgKZH#pZ;", 12345, Date.new(2017, 03, 28))
    assert_equal "Message decrypted with key: 12345 and date: 2017-03-28", d.decrypt
  end
end
