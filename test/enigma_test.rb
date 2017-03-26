require './test/test_helper.rb'
require "./lib/enigma"

class EnigmaTest < Minitest::Test
  def test_it_exists
    assert_instance_of Enigma, Enigma.new
  end

  def test_integration_of_runner_class
    enigma = Enigma.new
    my_message = "this is so secret ..end.."
    assert_equal 82, enigma.encrypt(my_message).length
  end
  
  def test_integration_encrypt_with_key_and_date
    enigma = Enigma.new
    my_message = "this is so secret ..end.."
    expected = "message was encrypted with key 12345. Encrypted message: *.;Q;/Ee&2YQq%DC*JUaq16a7"
    actual = enigma.encrypt(my_message, 12345, Date.new(2017,03,25))
    assert_equal expected, actual
  end

  def test_integration_decrypt_with_key_and_date
    e = Enigma.new
    expected = "this is so secret ..end.."
    my_message = "*.;Q;/Ee&2YQq%DC*JUaq16a7"
    actual = e.decrypt(my_message, 12345, Date.new(2017,03,25))
    assert_equal actual, expected
  end
end

