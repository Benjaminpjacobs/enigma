module KeyGen
  
  def generate(key)
    divided_key = key_into_array(key)
    rotations = output_rotations(divided_key)
  end

  def generate_original_key
    "%05d" % Random.rand(10000..99999) 
  end
  
  def key_into_array(key)
    key = key.to_s.split("").to_a
    key.map {|num| num.to_i}
  end
  
  def output_rotations(divided_key)
    rotations = []
    while divided_key.size > 1 do
      rotations << (divided_key.shift.to_s + divided_key.first.to_s).to_i
    end
    rotations
  end
end