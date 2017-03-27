require './test/test_helper.rb'
require './lib/encrypt'

class EncryptTest < Minitest::Test
  def test_it_exists
    assert_instance_of Encrypt, Encrypt.new
  end

  def test_it_encrypt_a_message
    e = Encrypt.new("./test/single_line.txt", "./test/encryptor_message.txt" )
    e.encrypt
    # assert File.read("./test/encryptor_message.txt")
    assert File.delete("./test/encryptor_message.txt")
  end

end