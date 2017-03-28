require './test/test_helper.rb'
require './lib/encrypt'
require 'pry'

class EncryptTest < Minitest::Test
  def test_it_exists
    assert_instance_of Encrypt, Encrypt.new
  end

  def test_it_encrypt_a_message
    input_file = "./test/single_line.txt"
    output_file = "./test/encryptor_message.txt"
    e = Encrypt.new(input_file, output_file)
    e.encrypt
    assert File.delete(output_file)
  end

  def test_it_can_encrypt_with_key_and_date
    input_file = "./test/single_line.txt"
    output_file = "./test/encrypted_message1.txt"
    e = Encrypt.new(input_file, 12345, Date.new(2017, 03, 27), output_file)
    e.encrypt
    expected = "^8L*J9VgmYF$p5GiJ7LQn5UX48>@qGVPs5"
    actual = File.read(output_file)
    assert_equal expected, actual
  end

end