require "minitest/autorun"
require "minitest/pride"
require "./lib/decrypt_message.rb"

class DecryptMessageTest < Minitest::Test
  def test_it_exists
    d = DecryptMessage.new
    assert_instance_of DecryptMessage, e
  end
end