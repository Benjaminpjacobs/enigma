require 'pry'
require './lib/encryptor'

class Message

  def initialize(message="")
    @message = message
  end

  def read_file
    @message = File.read(@message).gsub("\n", " ")
  end
  
  def parse
    @message = @message.split('')
  end
  
  def split_into_sub_arrays
    @message = @message.each_slice(4).to_a
  end
  
  def write_file(file_name)
    File.write(file_name, @message)
  end

  
end
