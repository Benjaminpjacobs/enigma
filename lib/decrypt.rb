require './lib/message_io'
require './lib/decrypt_message'

class Decrypt
  attr_reader :input, :output
  
  def initialize(input=nil, output=nil, key=nil, date=Date.today)
    @input = input
    @output = output  
    @key = key
    @date = date

  end
  def read_file
    messenger = MessageIO.new(@input)
    messenger.read_file
  end

  def write_file(output, message)
    messenger = MessageIO.new
    messenger.write_file(output, message)
  end

  def decrypt
    d = DecryptMessage.new
    d.instantiate_message(read_file, @key, @date)
    confirmation = d.decrypt
    write_file(@output,d.to_decrypt.message)
    p confirmation
  end
end

#######################
# d = Decrypt.new(ARGV[0], ARGV[1], ARGV[2])
# d.decrypt