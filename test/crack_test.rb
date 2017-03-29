require './test/test_helper'
require './lib/crack'

class CrackTest < Minitest::Test

  def setup
    @input = './test/encrypted_file.txt'
    @output = './test/cracked.txt'
    @date = Date.new(2017, 03, 29)
  end
  
  def test_it_exists
    c = Crack.new
    assert_instance_of Crack, c
  end

  def test_it_can_crack_file
    c = Crack.new(@input, @output, @date)
    expected = "Message cracked with key: 26078 and date: 2017-03-29"
    assert_equal expected, c.crack
  end
  
  def test_it_can_write_file
    c = Crack.new(@input, @output, @date)
    assert File.readlines('./test/cracked.txt')
  end
end
