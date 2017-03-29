require 'minitest/autorun'
require 'minitest/pride'
require './lib/message'

class MessageTest < Minitest::Test
  def test_it_exists
    m = Message.new
    assert_instance_of Message, m
  end
  def test_it_can_hold_message_date_and_key
    message = Message.new("message", 12345, Date.today)
    assert_equal "message", message.message
    assert_equal 12345, message.key
    assert_equal Date.today, message.date
    assert_nil  message.rotation
    assert_nil message.offset
  end
  def test_it_can_alter_instance_variables
    message = Message.new("message", 12345, Date.today)
    message.message = 'new_message'
    message.key = 54321
    message.date = Date.new(2017, 03, 26)
    message.rotation = [10,9,8,7]
    message.offset = [4,3,2,1]
    assert_equal 'new_message', message.message
    assert_equal 54321, message.key
    assert_equal Date.new(2017, 03, 26), message.date
    assert_equal [10,9,8,7], message.rotation
    assert_equal [4,3,2,1], message.offset
  end

end