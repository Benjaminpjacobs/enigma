require './test/test_helper'
require "./lib/decrypt_message.rb"

class DecryptMessageTest < Minitest::Test

  def setup
    @message = "y5V*m7HgKZH#pZ;"
    @key = 12345
    @date = Date.new(2017, 03, 28)
  end
  
  def test_it_exists
    d = DecryptMessage.new(@message, @key, @date)
    assert_instance_of DecryptMessage, d
  end
  
  def test_it_can_get_offset
    d = DecryptMessage.new(@message, @key, @date)
    d.get_offset
    assert_equal [0,4,8,9], d.to_decrypt.offset
  end

  def test_it_can_get_rotations
    d = DecryptMessage.new(@message, @key, @date)
    d.get_offset
    d.get_rotations
    assert_equal [12, 23, 34, 45], d.to_decrypt.rotation
  end

  def test_it_can_parse_and_split
    d = DecryptMessage.new(@message, @key, @date)
    d.parse_and_split_message
    expected = [["y", "5", "V", "*"],
                ["m", "7", "H", "g"],
                ["K", "Z", "H", "#"],
                ["p", "Z", ";"]] 
    assert_equal expected, d.to_decrypt.message
  end

  def test_it_can_decrypt_message
    d = DecryptMessage.new(@message, @key, @date)
    expected = "Message decrypted with key: 12345 and date: 2017-03-28"
    assert_equal expected, d.decrypt
  end
end
