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
    expected = [62, 52, 83, 83]
    assert_equal expected, actual
    c = Crack.new("123456789")
    actual = c.comparison_index
    expected = [53, 62, 52, 83]
    assert_equal expected, actual
    c = Crack.new("1234567890")
    actual = c.comparison_index
    expected = [83, 53, 62, 52]
    assert_equal expected, actual
    c = Crack.new("12345678901")
    actual = c.comparison_index
    expected = [83, 83, 53, 62]
    assert_equal expected, actual  
  end

  def test_find_character_indexes
    c = Crack.new("rjwxtsvp")
    actual = c.find_character_indexes
    expected = [68, 67, 70, 64]
    assert_equal expected, actual
  end

  def test_find_rotations
    c = Crack.new("7F7LpFU")
    actual = c.find_rotations
    expected = [12, 27, 42, 54]
    assert_equal expected, actual
  end

  def test_decrypt
    c = Crack.new("7F7LpFU")
    expected = "..end.."
    actual = c.decrypt
    assert_equal expected, actual
    end
end