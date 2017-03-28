require './test/test_helper.rb'
require './lib/encrypt'
require 'pry'

class EncryptTest < Minitest::Test
  def test_it_exists
    assert_instance_of Encrypt, Encrypt.new
  end

  def test_it_encrypt_a_message
    e = Encrypt.new("./test/single_line.txt", "./test/encryptor_message.txt" )
    e.encrypt
    assert File.delete("./test/encryptor_message.txt")
  end

  # def test_it_can_encrypt_with_key_and_date
  #   e = Encrypt.new("./test/single_line.txt","./test/encrypted_message1.txt", 12345, Date.new(2017, 03, 27))
  #   e.encrypt
  #   expected = "^8L*J9VgmYF$p5GiJ7LQn5UX48>@qGVPs5"
  #   actual = File.read("./test/encrypted_message1.txt")
  #   assert_equal expected, actual
  # end

end