require './test/test_helper.rb'
require './lib/cryptor'

class CryptorTest < Minitest::Test

  def test_it_exists
    assert_instance_of Cryptor, Cryptor.new("hello")
  end

  # def test_it_can_take_three_args
  #   enigma = Cryptor.new("hello", 12345, Date.today)
  #   assert_equal "hello", enigma.message
  #   assert_equal 12345, enigma.key
  #   assert_equal Date.today, enigma.date
  # end

  def test_it_can_interact_with_message_class
    enigma = Cryptor.new("hello, there")
    enigma.parse_and_split
    expected = [["h", "e", "l", "l"],
                ["o", ",", " ", "t"],
                ["h", "e", "r", "e"]]
    assert_equal expected, enigma.parse_and_split
  end

  # def test_it_can_generate_rotation
  #   enigma = Cryptor.new("hello, there")
  #   actual = enigma.key_into_rotation
  #   assert_instance_of Array, actual
  #   assert_equal 4, actual.length
  # end

  # def test_it_can_convert_rotation
  #   enigma = Cryptor.new("hello, there", 12345)
  #   actual = enigma.key_into_rotation
  #   assert_equal [12, 23, 34, 45], actual
  # end

  # def test_it_can_generate_offset
  #   enigma = Cryptor.new("hi, my name is bob", 98763)
  #   assert_instance_of Array, enigma.date_into_offset
  #   assert_equal 4, enigma.date_into_offset.length
  # end

  # def test_it_can_convert_date_offset
  #   enigma = Cryptor.new("hi, my name is bob", 12345, Date.new(2001,5, 5))
  #   assert_equal [1,0,0,1], enigma.date_into_offset
  # end

  def test_can_create_roto_offset
    enigma = Cryptor.new("hi, my name is bob", 12345, Date.new(2001,5, 5))
    actual =  enigma.rotation_and_offset
    assert_equal [13, 23, 34, 46], actual
  end

  # def test_cipher_letter
  #   enigma = Cryptor.new("hello")
  #   actual = enigma.cipher(10, "A")
  #   assert_equal "K", actual
  # end

  # def test_cipher_letter
  #   enigma = Cryptor.new("hello")
  #   actual = enigma.cipher(10, "1")
  #   assert_equal ".", actual
  # end

  # def test_cipher_letter
  #   enigma = Cryptor.new("hello")
  #   actual = enigma.cipher(10, "?")
  #   assert_equal "i", actual
  # end

  def test_small_encryption
    enigma = Cryptor.new("hell", 10102, Date.new(2017, 3, 24))
    actual = enigma.crypt(:ENCRYPT)
    assert_equal "rj3w", actual
  end

  def test_small_decryption
    enigma = Cryptor.new("rj3w", 10102, Date.new(2017, 3, 24))
    actual = enigma.crypt(:DECRYPT)
    assert_equal "hell", actual
  end

  def test_encryption_with_space
    enigma = Cryptor.new("hello, there", 10102, Date.new(2017, 3, 24))
    actual = enigma.crypt(:ENCRYPT)
    assert_equal "rj3wyEP4rj9p", actual
  end
  
  def test_decryption_with_space
    enigma = Cryptor.new("rj3wyEP4rj9p", 10102, Date.new(2017, 3, 24))
    actual = enigma.crypt(:DECRYPT)
    assert_equal "hello, there", actual
  end

end