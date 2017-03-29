require './test/test_helper'
require './lib/decrypt'

class DecryptTest < Minitest::Test
  
  def setup
    @input = './test/single_line_encrypted.txt'
    @output = './test/single_line_decrypted.txt'
    @key = 23145
    @date = Date.new(2017, 03, 29)
  end
  
  def test_it_exists
    d = Decrypt.new
    assert_instance_of Decrypt, d
  end

  def test_it_can_decrypt_file
    d = Decrypt.new(@input, @output, @key, @date)
    expected = "Message decrypted with key: 23145 and date: 2017-03-29"
    assert_equal expected, d.decrypt
  end
  
  def test_it_can_write_file
    d = Decrypt.new(@input, @output, @key, @date)
    d.decrypt
    expected = File.readlines(@output).join
    actual = "This is my long super secret message ..end.."
    assert_equal expected, actual
  end
end
