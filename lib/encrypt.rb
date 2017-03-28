require './lib/cryptor'
require './lib/message_io'
require 'pry'

class Encrypt < Cryptor
  def initialize(message=nil, output=nil, key=nil, date=nil)
    @message = message
    @output = output
    @key = key
    @date = date
  end
  
  def encrypt
    messenger = MessageIO.new(@message)
    @message= messenger.read_file
    rotation = rotation_and_offset
    encrypted = run_the_cipher(rotation)
    messenger.write_file(@output, encrypted)
    p "Created #{@output} with key of #{key} and date #{date}"
  end
  
end

###########################################

#e = Encrypt.new(ARGV[0], ARGV[1])
#e.encrypt