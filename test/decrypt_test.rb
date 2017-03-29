require './test/test_helper'
require './lib/decrypt'

class EncryptTest < Minitest::Test
  
  def setup
    @input = './test/encrypted_file.txt'
    @output = './test/decrypted_file.txt'
    @key = 26078
    @date = Date.new(2017, 03,29)
  end
  
  def test_it_exists
    d = Decrypt.new
    assert_instance_of Decrypt, d
  end

  def test_it_can_decrypt_file
    d = Decrypt.new(@input, @output, @key, @date)
    expected = "Message decrypted with key: 26078 and date: 2017-03-29"
    assert_equal expected, d.decrypt
  end
  
  def test_it_can_write_file
    d = Decrypt.new(@input, @output, @key, @date)
    d.decrypt
    assert File.readlines(@output)
  end
end
