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
end