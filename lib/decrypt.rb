require './lib/cryptor'
require './lib/message_io'
require 'pry'

class Decrypt < Cryptor

  def initialize(message=nil, key=nil, date=nil, output=nil)
    @message = message
    @key = key
    @date = date
    @output = output
  end

  def decrypt
    messenger = MessageIO.new(@message)
    if @message.end_with?(".txt")
      @message= messenger.read_file
    end
    rotation = rotation_and_offset
    decrypted  = run_the_cipher(rotation.map!{|num| num * -1})
    unless @output.nil?
      messenger.write_file(@output, decrypted)
      p "Created #{@output} with key of #{key} and date #{date}"
    else 
      decrypted
    end
  end

end

####################################

# d = Decrypt.new(ARGV[0], ARGV[2], ARGV[3], ARGV[1],)
# d.decrypt
