require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'

class EncryptTest < Minitest::Test
  def test_it_exists
    e = Encrypt.new
    assert_instance_of Encrypt, e
  end
  def test_it_accept_two_arguments
    e = Encrypt.new('./test/single_line.txt', './test/encrypted_file.txt')
    assert_equal './test/single_line.txt', e.input
    assert_equal './test/encrypted_file.txt', e.output
  end
  def test_it_can_encrypt_file
    e = Encrypt.new('./test/single_line.txt', './test/encrypted_file.txt', 26078)
    expected = "Message encrypted with key: 26078 and date: 2017-03-29"
    assert_equal expected, e.encrypt
  end
  def test_it_can_write_file
    e = Encrypt.new('./test/single_line.txt', './test/encrypted_file.txt', 26078)
    e.encrypt
    assert File.readlines('./test/encrypted_file.txt')
  end
end