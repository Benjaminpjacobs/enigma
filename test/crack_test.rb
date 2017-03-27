require "./test/test_helper.rb"
require "./lib/crack.rb"


class CrackTest < Minitest::Test

  def test_it_exists
    assert_instance_of Crack, Crack.new
  end
  
  def test_it_can_take_multiple_args
    c = Crack.new("hello")
    assert_equal "hello", c.message
    c = Crack.new("hello", 12345)
    assert_equal 12345, c.key
    c = Crack.new("hello", Date.today)
    assert_equal Date.today, c.date
    c = Crack.new("hello", 12345, Date.today)
    assert_equal 12345, c.key
    assert_equal Date.today, c.date
    c = Crack.new("hello.txt", "output.txt", 12345, Date.today)
    assert_equal 12345, c.key
    assert_equal Date.today, c.date
    assert_equal "output.txt", c.output
  end

  def test_it_can_find_last_group_of_four
    c = Crack.new("hello ..end..")
    actual = c.last_group_of_four
    expected = ['e', 'n', 'd', '.']
    assert_equal expected, actual
  end

  def test_it_can_determine_comparison_index
    c = Crack.new("12345678")
    actual = c.comparison_index
    expected = [13, 3, 37, 37]
    assert_equal expected, actual
    c = Crack.new("123456789")
    actual = c.comparison_index
    expected = [4, 13, 3, 37]
    assert_equal expected, actual
    c = Crack.new("1234567890")
    actual = c.comparison_index
    expected = [37, 4, 13, 3]
    assert_equal expected, actual
    c = Crack.new("12345678901")
    actual = c.comparison_index
    expected = [37, 37, 4, 13]
    assert_equal expected, actual  
  end

  def test_find_character_indexes
    c = Crack.new("rj3w")
    actual = c.find_character_indexes
    expected = [17, 9, 29, 22]
    assert_equal expected, actual
  end

  def test_find_rotations
    c = Crack.new("KZH#pZ;")
    actual = c.find_rotations
    expected = [12, 27, 42, 54]
    assert_equal expected, actual
  end

  def test_decrypt
    c = Crack.new("KZH#pZ;")
    expected = "..end.."
    actual = c.decrypt
    assert_equal expected, actual
  end

  def test_decrypt_longer
    c = Crack.new("58L*J9VgmYP)o8>!0BJT3YPT4GDVqYV$J8R%q6X!xM>(t9Vg8CN&4Y;hqBGhK")
    expected = "this is a much longer message so hopefully this wokrs ..end.."
    actual = c.decrypt
    assert_equal expected, actual
  end

  def test_crack_key_and_dates
    c = Crack.new
    actual = c.crack_key_and_date([14, 25, 39, 51])
    expected = "cracked with key: 12345 and date 2016-10-31"
    assert_equal expected, actual
  end

  def test_decrypt_and_crack_key_and_date
    c = Crack.new("58L*J9VgmYP)o8>!0BJT3YPT4GDVqYV$J8R%q6X!xM>(t9Vg8CN&4Y;hqBGhK")
    expected = "message: 'this is a much longer message so hopefully this wokrs ..end..', cracked with key: 12345 and date 2017-03-26"
    actual = c.crack
    assert_equal expected, actual
  end
  
  def test_it_can_read_message_file
    c = Crack.new("./test/encrypted_message.txt", "./test/decrypted_file.txt")
    c.read_file
    expected = "58L*J9VgmYP)o8>!0BJT3YPT4GDVqYV$J8R%q6X!xM>(t9Vg8CN&4Y;hqBGhK"
    assert_equal expected, c.message
  end

  def test_it_can_crack_message_file
    c = Crack.new("./test/encrypted_message.txt", "./test/decrypted_message.txt")
    c.read_file
    expected = "message: 'this is a much longer message so hopefully this wokrs ..end..', cracked with key: 12345 and date 2017-03-26"
    assert_equal expected, c.crack
  end
  
  def test_it_can_write_cracked_file
    c = Crack.new("./test/encrypted_message.txt", "./test/decrypted_message.txt")
    c.write_decrypted_file
    decrypted_file = "./test/decrypted_message.txt"
    actual = File.readlines(decrypted_file).join
    expected = "message: 'this is a much longer message so hopefully this wokrs ..end..', cracked with key: 12345 and date 2017-03-26"
    binding.pry
    assert_equal expected, actual
  end
  
end