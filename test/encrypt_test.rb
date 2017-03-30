require './test/test_helper'
require './lib/encrypt'

class EncryptTest < Minitest::Test
  def test_it_exists
    e = Encrypt.new
    assert_instance_of Encrypt, e
  end

  def test_it_can_encrypt_file
    e = Encrypt.new('./test/test_files/single_line.txt', './test/test_files/encrypted_file.txt', 26078)
    expected = "Message encrypted with key: 26078 and date: 2017-03-30"
    assert_equal expected, e.encrypt
  end
  
  def test_it_can_write_file
    e = Encrypt.new('./test/test_files/single_line.txt', './test/test_files/encrypted_file.txt', 26078)
    e.encrypt
    assert File.readlines('./test/test_files/encrypted_file.txt')
  end
  
  def test_it_can_encrypt_and_write_larger_file
    e = Encrypt.new('./test/test_files/multi_line_file.txt', './test/test_files/multi_line_file_encrypted.txt', 26078)
    e.encrypt
    assert File.readlines('./test/test_files/multi_line_file_encrypted.txt')
  end
end