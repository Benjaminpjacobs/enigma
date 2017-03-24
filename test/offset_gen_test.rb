require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require './lib/offset_gen'

class OffsetTest < Minitest::Test

  def test_instance_of_offset_gen
    generator = OffsetGen.new
    assert_instance_of OffsetGen, generator
  end
  
  def test_default_date_is_today
    generator = OffsetGen.new
    date_today = Date.today
    assert_equal date_today, generator.date
  end

  def test_pass_date_not_today
    date = Date.new(2001, 2, 3)
    generator = OffsetGen.new(date)
    assert_equal date, generator.date
    refute Date.today == generator.date
  end
  
  def test_convert_into_offset
    date = Date.new(2001, 2, 13)
    generator = OffsetGen.new(date)
    expected = [0, 4, 0, 1]
    assert_equal expected, generator.convert_into_offset
  end
end