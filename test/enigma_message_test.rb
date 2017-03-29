require './test/test_helper'
require './lib/enigma_message'

class EnigmaMessageTest < Minitest::Test
  def test_it_exists
    e = Enigma.new
    assert_instance_of Enigma, e
  end
  def test_it_can_encrypt_message
    e = Enigma.new
    actual = e.encrypt("message .. end..").length
    expected = 16
    assert_equal expected, actual
  end
  def test_it_can_decrypt_message
    e = Enigma.new
    actual = e.decrypt("y5V*m7HgKZH#pZ;", 12345, Date.new(2017, 03, 28))
    expected = "message ..end.."
    assert_equal expected, actual
  end
  def test_it_can_crack_message
    e = Enigma.new
    actual = e.crack("y5V*m7HgKZH#pZ;", Date.new(2017, 03, 28))
    expected = "message ..end.."
    assert_equal expected, actual
  end
end