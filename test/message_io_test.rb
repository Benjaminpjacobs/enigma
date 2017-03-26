require './test/test_helper.rb'
require "./lib/message_io"
require 'pry'

class MessageIOTest < Minitest::Test
  def test_instance_of_message_class
    message = MessageIO.new
    assert_instance_of MessageIO, message
  end
  
  def test_read_small_text_file
    file_name = "./test/small_file.txt"
    message = MessageIO.new(file_name)
    actual = message.read_file
    expected = "Each House shall be the Judge of the Elections"
    assert_equal expected, actual
  end
  
  def test_read_multi_line_file
    file_name = "./test/multi_line_file.txt"
    message = MessageIO.new(file_name)
    actual = message.read_file
    expected = "Each House shall be the Judge of the Elections, Returns and Qualifications of its own Members, and a Majority of each shall constitute a Quorum to do Business; but a smaller number may adjourn from day to day, and may be authorized to compel the Attendance of absent Members, in such Manner, and under such Penalties as each House may provide."
    assert_equal expected, actual
  end

  def test_it_can_parse_message
    file_name = "./test/small_file.txt"
    message = MessageIO.new(file_name)
    message.read_file
    actual = message.parse
    expected = "Each House shall be the Judge of the Elections".chars
    assert_equal expected, actual  
  end

  def test_it_can_split_into_sub_arrays
    file_name = "./test/small_file.txt"
    message = MessageIO.new("Lincoln")
    expected = [["L", "i", "n", "c"], ["o", "l", "n"]]
    message.parse
    actual = message.split_into_sub_arrays
    assert_equal expected, actual
  end
  
  def test_it_can_write_single_line_file
    new_message = "This is a coded, gibberish message"
    output = MessageIO.new(new_message)
    output.write_file("./test/single_line.txt")
    assert_equal File.read("./test/single_line.txt"), new_message
  end
end
