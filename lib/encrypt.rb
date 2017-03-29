require './lib/message_io'
require './lib/encrypt_message'

class Encrypt
  attr_reader :input, :output
  
  def initialize(input=nil, output=nil, key=nil)
    @input = input
    @output = output  
    @key = key
  end

  def read_file
    messenger = MessageIO.new(@input)
    messenger.read_file
  end

  def write_file(filename, message)
    messenger = MessageIO.new
    messenger.write_file(filename, message)
    
  end

  def encrypt
    e = EncryptMessage.new
    e.instantiate_message(read_file, @key)
    confirmation = e.encrypt
    write_file(@output,e.to_encrypt.message)
    p confirmation
  end

end

#########################
# e = Encrypt.new(ARGV[0], ARGV[1], ARGV[2])
# e.encrypt