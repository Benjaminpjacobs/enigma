require 'simplecov'
SimpleCov.start

gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./lib/enigma"

class EnigmaTest < Minitest::Test
  def test_it_exists
    assert_instance_of Enigma, Enigma.new
  end

  def test_it_can_encrypt_a_message
    e = Enigma.new
    my_message = "this is so secret ..end.."
    output = e.encrypt(my_message)
    assert_equal my_message.length, output.length
  end
  # def
  #   expected = "Eq|UXr7iDxKU6l6GE8Ge6w*eT"
  # end
end

