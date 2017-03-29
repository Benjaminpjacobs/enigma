module MessageIO

  def read_file(file_name)
    File.read(file_name).gsub("\n", " ")
  end
  
  def parse(message)
    message.split('')
  end
  
  def split_into_sub_arrays(message)
    message.each_slice(4).to_a
  end
  
  def write_file(file_name, message)
    File.write(file_name, message)
  end

end
