require './test/test_helper.rb'
require './lib/key_gen'

class KeyGenTest < Minitest::Test

  def test_instance_of_keygen
    key_gen = KeyGen.new
    assert_instance_of KeyGen, key_gen
  end
  
  def test_create_random_number
    key_gen = KeyGen.new
    key_gen.generate_original
    key = key_gen.key
    puts "\n#{key}\n"
    assert_equal 5, key.length
  end

  def test_key_into_array
    key_gen = KeyGen.new
    number = 83457
    seperated_nums = key_gen.key_into_array(number)
    assert_equal [8,3,4,5,7], seperated_nums
  end

   def test_key_into_array_with_zeros
    key_gen = KeyGen.new
    number = 10013
    seperated_nums = key_gen.key_into_array(number)
    assert_equal [1,0,0,1,3], seperated_nums
  end
  
  def test_output_rotations
    key_gen = KeyGen.new
    key = [9,3,1,7,4]
    rotations = key_gen.output_rotations(key)
    assert_equal [93,31,17,74], rotations
  end

  def test_convert_key
    key_gen = KeyGen.new
    key = 65342
    expected =[65, 53, 34, 42]
    assert_equal expected, key_gen.convert_key(65342)
  end
  def test_generate_new
    key_gen = KeyGen.new
    assert_equal 4, key_gen.generate.length
  end
  def test_next_key
    key_gen = KeyGen.new(12346)
    expected = [12, 23, 34, 47]
    actual = key_gen.next_key
    assert_equal expected, actual
  end
end
