require 'minitest/autorun'
require 'minitest/pride'
require './lib/decrypt'

class EncryptTest < Minitest::Test
  def test_it_exists
    d = Decrypt.new
    assert_instance_of Decrypt, d
  end
  def test_it_accept_four_arguments
    d = Decrypt.new('./test/encrypted_file.txt','./test/decrypted_file.txt', 26078, Date.new(2017, 03,29))
    assert_equal './test/encrypted_file.txt', d.input
    assert_equal './test/decrypted_file.txt', d.output
  end
  def test_it_can_decrypt_file
    d = Decrypt.new('./test/encrypted_file.txt','./test/decrypted_file.txt', 26078, Date.new(2017, 03,29))
    expected = "Message decrypted with key: 26078 and date: 2017-03-29"
    assert_equal expected, d.decrypt
  end
  def test_it_can_write_file
    d = Decrypt.new('./test/encrypted_file.txt','./test/decrypted_file.txt', 26078, Date.new(2017, 03,29))
    d.decrypt
    assert File.readlines('./test/decrypted_file.txt')
  end
end
