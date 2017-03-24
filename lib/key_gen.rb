class KeyGen
  attr_reader :key
  def initialize
    @key = 0
  end
  
  def generate
    key = generate_original  
    key = key_into_array(key)
    key = output_rotations(key)
  end

  def generate_original
    @key = "%05d" % Random.rand(99999) 
  end

  def convert_key(number)
    key = key_into_array(number)
    key = output_rotations(key)
  end
  
  def key_into_array(numbers=@key)
    numbers = numbers.to_s.split("").to_a
    numbers.map {|num| num.to_i}
  end
  
  def output_rotations(numbers=[])
    rotations = []
    first_num = 0
    while numbers.size > 1 do
      first_num = numbers.shift
      result = first_num.to_s + numbers.first.to_s
      rotations << result.to_i
    end
    rotations
  end
  
end