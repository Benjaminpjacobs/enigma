require "./test/test_helper.rb"
require "./lib/crack.rb"


class CrackTest < Minitest::Test

  def test_it_exists
    assert_instance_of Crack, Crack.new
  end
  
  def test_it_can_take_multiple_args
    a = Crack.new("hello")
    assert_equal "hello", a.message

    d = Crack.new("hello", Date.today)
    assert_equal Date.today, d.date

    e = Crack.new("hello.txt", "output.txt", Date.today)
    assert_equal Date.today, e.date
    assert_equal "output.txt", e.output
  end

  def test_it_can_find_last_group_of_four
    c = Crack.new("hello ..end..")
    assert_equal ['e', 'n', 'd', '.'], c.last_group_of_four
  end

  def test_it_can_determine_comparison_index
    a = Crack.new("12345678")
    assert_equal [13, 3, 37, 37], a.comparison_index

    b = Crack.new("123456789")
    assert_equal [4, 13, 3, 37], b.comparison_index

    c = Crack.new("1234567890")
    assert_equal [37, 4, 13, 3], c.comparison_index

    d = Crack.new("12345678901")
    assert_equal [37, 37, 4, 13], d.comparison_index  
  end

  def test_find_character_indexes
    c = Crack.new("rj3w")
    actual = c.find_character_indexes
    assert_equal [17, 9, 29, 22], actual
  end

  def test_find_rotations
    c = Crack.new("KZH#pZ;")
    actual = c.find_rotations
    assert_equal [12, 27, 42, 54], actual
  end

  def test_decrypt
    c = Crack.new("KZH#pZ;")
    assert_equal "..end..", c.decrypt
  end

  def test_decrypt_longer
    c = Crack.new("58L*J9VgmYP)o8>!0BJT3YPT4GDVqYV$J8R%q6X!xM>(t9Vg8CN&4Y;hqBGhK")
    expected = "this is a much longer message so hopefully this wokrs ..end.."
    assert_equal expected, c.decrypt
  end

  def test_key_from_date
    e = Crack.new
    expected = "28171"
    actual = e.key_from_date([28,45,65,20], Date.new(2017, 03, 28))
    assert_equal expected, actual
  end
  
  def test_it_can_read_message_file
    input_file = "./test/encrypted_message.txt"
    output_file = "./test/decrypted_file.txt"
    c = Crack.new(input_file, output_file)
    c.read_file
    expected = "58L*J9VgmYP)o8>!0BJT3YPT4GDVqYV$J8R%q6X!xM>(t9Vg8CN&4Y;hqBGhK"
    assert_equal expected, c.message
  end

  def test_it_can_crack_message_file
    input_file = "./test/encrypted_message.txt"
    output_file = "./test/decrypted_message.txt"
    c = Crack.new(input_file, output_file)
    c.read_file
    expected = "Created ./test/decrypted_message.txt with key of 12345 and date "
    assert_equal expected, c.crack
  end
  
  def test_it_can_write_cracked_file
    input_file = "./test/encrypted_message.txt"
    output_file = "./test/decrypted_message.txt"
    c = Crack.new(input_file, output_file)
    c.write_decrypted_file
    decrypted_file = "./test/decrypted_message.txt"
    expected = "Created ./test/decrypted_message.txt with key of 12345 and date "
    actual = File.readlines(decrypted_file).join
    assert_equal expected, actual
  end
  
end