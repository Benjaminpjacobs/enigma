require 'pry'
class KeyGen
  attr_reader :key
  def initialize(key=0)
    @key = key
  end
  
  def generate
    generate_original  
    divided_key = key_into_array(@key)
    rotations = output_rotations(divided_key)
  end

  def generate_original
    @key = "%05d" % Random.rand(10000..99999) 
  end

  def convert_key(incoming_key)
    divided_key = key_into_array(incoming_key)
    rotations = output_rotations(divided_key)
  end
  
  def key_into_array(numbers=@key)
    numbers = numbers.to_s.split("").to_a
    numbers.map {|num| num.to_i}
  end
  
  def output_rotations(divided_key)
    rotations = []
    while divided_key.size > 1 do
      rotations << (divided_key.shift.to_s + divided_key.first.to_s).to_i
    end
    rotations
  end

  def next_key
    @key += 1
    convert_key(@key)
  end
end