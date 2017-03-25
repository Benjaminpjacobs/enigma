require 'simplecov'
SimpleCov.start

gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./lib/encryptor"
require 'pry'
class EncryptorTest < Minitest::Test

  def test_it_exists
    assert_instance_of Encryptor, Encryptor.new("hello")
  end

  def test_it_can_take_three_args
    enigma = Encryptor.new("hello", 12345, Date.today)
    assert_equal "hello", enigma.message
    assert_equal 12345, enigma.key
    assert_equal Date.today, enigma.date
  end

  def test_it_can_interact_with_message_class
    enigma = Encryptor.new("hello, there")
    enigma.parse_and_split
    expected = [["h", "e", "l", "l"], ["o", ",", " ", "t"], ["h", "e", "r", "e"]]
    assert_equal expected, enigma.parse_and_split
  end

  def test_it_can_generate_rotation
    enigma = Encryptor.new("hello, there")
    actual = enigma.key_into_rotation
    assert_instance_of Array, actual
    assert_equal 4, actual.length
  end

  def test_it_can_convert_rotation
    enigma = Encryptor.new("hello, there", 12345)
    actual = enigma.key_into_rotation
    assert_equal [12, 23, 34, 45], actual
  end

  def test_it_can_generate_offset
    enigma = Encryptor.new("hi, my name is bob", 98763)
    assert_instance_of Array, enigma.date_into_offset
    assert_equal 4, enigma.date_into_offset.length
  end

  def test_it_can_convert_date_offset
    enigma = Encryptor.new("hi, my name is bob", 12345, Date.new(2001,5, 5))
    assert_equal [1,0,0,1], enigma.date_into_offset
  end

  def test_can_create_roto_offset
    enigma = Encryptor.new("hi, my name is bob", 12345, Date.new(2001,5, 5))
    expected = [13, 23, 34, 46]
    actual =  enigma.rotation_and_offset
    assert_equal expected, actual
  end

  def test_cipher_letter
    enigma = Encryptor.new("hello")
    actual = enigma.cipher(10, "A")
    assert_equal "K", actual
  end

  def test_cipher_letter
    enigma = Encryptor.new("hello")
    actual = enigma.cipher(10, "0")
    assert_equal ":", actual
  end

  def test_cipher_letter
    enigma = Encryptor.new("hello")
    actual = enigma.cipher(10, "?")
    assert_equal "I", actual
  end

  def test_small_encryption
    enigma = Encryptor.new("hell", 10102, Date.new(2017, 3, 24))
    actual = enigma.encrypt("encrypt")
    expected = "rj%w"
    assert_equal expected, actual
  end

  def test_small_decryption
    enigma = Encryptor.new("rj%w", 10102, Date.new(2017, 3, 24))
    actual = enigma.encrypt("decrypt")
    expected = "hell"
    assert_equal expected, actual
  end

  def test_encryption_with_space
    enigma = Encryptor.new("hello, there", 10102, Date.new(2017, 3, 24))
    actual = enigma.encrypt("encrypt")
    expected = "rj%wy3A&rj/p"
    assert_equal expected, actual
  end
  
  def test_decryption_with_space
    enigma = Encryptor.new("rj%wy3A&rj/p", 10102, Date.new(2017, 3, 24))
    actual = enigma.encrypt("decrypt")
    expected = "hello, there"
    assert_equal expected, actual
  end
end