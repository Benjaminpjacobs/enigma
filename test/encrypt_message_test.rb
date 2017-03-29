require "minitest/autorun"
require "minitest/pride"
require "./lib/encrypt_message.rb"

class EncryptMessageTest < Minitest::Test
  def test_it_exists
    e = EncryptMessage.new
    assert_instance_of EncryptMessage, e
  end
  def test_it_can_create_message_object
    e = EncryptMessage.new
    actual = e.instantiate_message("message ..end..", 12345, Date.today)
    assert_instance_of Message, actual
  end
  def test_it_holds_date
    e = EncryptMessage.new
    e.instantiate_message("message ..end..", 12345, Date.today)
    assert_equal "message ..end..", e.to_encrypt.message
  end

  def test_it_can_get_offset
    e = EncryptMessage.new
    e.instantiate_message("message ..end..", 12345, Date.today)
    e.get_offset
    assert_equal [0,4,8,9], e.to_encrypt.offset
  end
  def test_it_can_get_rotations
    e = EncryptMessage.new
    e.instantiate_message("message ..end..", 12345, Date.today)
    e.get_offset
    e.get_rotations
    assert_equal [12, 23, 34, 45], e.to_encrypt.rotation
  end
  def test_it_can_parse_and_split
    e = EncryptMessage.new
    e.instantiate_message("message ..end..", 12345, Date.today)
    e.parse_and_split_message
    assert_equal [["m", "e", "s", "s"], ["a", "g", "e", " "], [".", ".", "e", "n"], ["d", ".", "."]] , e.to_encrypt.message
  end
  def test_it_can_encrypt_message
    e = EncryptMessage.new
    e.instantiate_message("message ..end..", 12345, Date.new(2017, 03, 28))
    assert_equal "Message: y5V*m7HgKZH#pZ;. Encrypted with key: 12345 and date: 2017-03-28", e.encrypt
  end
end
