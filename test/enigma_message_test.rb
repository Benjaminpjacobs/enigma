require './test/test_helper'
require './lib/enigma_message'

class EnigmaMessageTest < Minitest::Test
  
  def setup
    @message = "message ..end.."
    @key = 12345
    @encrypted_message = "y5V*m7HfKZH#pZ;"
    @date = Date.new(2017, 03, 28)
  end
  
  def test_it_exists
    e = Enigma.new
    assert_instance_of Enigma, e
  end

  def test_it_can_encrypt_message
    e = Enigma.new
    assert e.encrypt(@message)
  end

  def test_encrypt_with_message_and_key_and_date
    e = Enigma.new
    actual = e.encrypt(@message, @key, @date)
    assert_equal @encrypted_message, actual
  end
  
  def test_it_can_decrypt_message
    e = Enigma.new
    actual = e.decrypt(@encrypted_message, @key, @date)
    assert_equal @message, actual
  end

  def test_it_can_crack_message
    e = Enigma.new
    actual = e.crack(@encrypted_message, @date))
    assert_equal @message, actual
  end
end
