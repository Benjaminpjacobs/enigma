require './test/test_helper.rb'
require './lib/decrypt'

class DecryptTest < Minitest::Test
  def test_it_exists
    assert_instance_of Decrypt, Decrypt.new
  end

  def test_it_decrypt_a_message
    input_file = "./test/encrypted_message1.txt"
    output_file = "./test/decrypted_message.txt"
    e = Decrypt.new(input_file, 12345, "270317", output_file)
    expected = "Created ./test/decrypted_message.txt " + 
               "with key of 12345 and date 270317"
    actual = e.decrypt
    assert_equal expected, actual
    expected = 'This is a coded, gibberish message'
    actual = File.read(output_file)
    assert_equal expected, actual
  end

end