require './test/test_helper.rb'
require './lib/decrypt'

class DecryptTest < Minitest::Test
  def test_it_exists
    assert_instance_of Decrypt, Decrypt.new
  end

  def test_it_decrypt_a_message
    e = Decrypt.new("./test/encrypted_message1.txt", "./test/decrypted_message.txt", 12345, "270317")
    actual = e.decrypt
    expected = "Created ./test/decrypted_message.txt with key of 12345 and date 2017-03-27"
    assert_equal expected, actual
    actual = File.read("./test/decrypted_message.txt")
    expected = 'This is a coded, gibberish message'
    assert_equal expected, actual
  end

end