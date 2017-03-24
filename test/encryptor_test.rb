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
  def test_it_can_parse_message_into_array
    enigma = Encryptor.new("hello, there")
    expected = ['h','e','l','l','o',',',' ', 't', 'h','e', 'r', 'e']
    assert_equal expected, enigma.parse
  end
  def test_it_can_split_message_into_sub_arrays
    enigma = Encryptor.new("hello, there")
    enigma.parse
    expected = [["h", "e", "l", "l"], ["o", ",", " ", "t"], ["h", "e", "r", "e"]]
    assert_equal expected, enigma.split_into_sub_arrays
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
    actual = enigma.cipher(1, "A")
    assert_equal "B", actual
  end
  def test_small_encryption
    enigma = Encryptor.new("hello", 10102)
    actual = enigma.encrypt
    expected = "rjdwy"
    assert_equal expected, actual
  end

end