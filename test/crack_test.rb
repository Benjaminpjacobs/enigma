require './test/test_helper'
require './lib/crack'

class CrackTest < Minitest::Test

  def setup
    @input = './test/test_files/encrypted_file.txt'
    @output = './test/test_files/cracked.txt'
    @date = Date.new(2017, 03, 29)
  end
  
  def test_it_exists
    c = Crack.new
    assert_instance_of Crack, c
  end

  def test_it_can_crack_file
    c = Crack.new(@input, @output, @date)
    c.crack
    expected = "Message cracked with key: 26078 and date: 2017-03-29"
    assert_equal expected, c.crack
  end
  
  def test_it_can_write_file
    c = Crack.new(@input, @output, @date)
    c.crack
    actual = File.read('./test/test_files/cracked.txt')
    expected = "This is a coded, gibberish message ..end.."
    assert_equal expected, actual
  end

  def test_it_can_crack_and_write_larger_file
    c = Crack.new('./test/test_files/multi_line_file.txt', './test/test_files/multi_line_file_cracked.txt', Date.new(2017, 03, 29))
    c.crack
    assert File.readlines('./test/test_files/multi_line_file.txt', './test/test_files/multi_line_file_cracked.txt')
  end
end
