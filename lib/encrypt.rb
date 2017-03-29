require './lib/message_io'
require './lib/encrypt_message'

class Encrypt
  include MessageIO
  
  def initialize(input=nil, output=nil, key=nil)
    @input = input
    @output = output  
    @key = key
  end

  def encrypt
    message = read_file(@input)
    e = EncryptMessage.new(message, @key)
    confirmation = e.encrypt
    write_file(@output,e.to_encrypt.message)
    p confirmation
  end
end

# #########################
# e = Encrypt.new(ARGV[0], ARGV[1], ARGV[2])
# e.encrypt