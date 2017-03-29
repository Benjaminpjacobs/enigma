require './lib/cryptor'
require './lib/message_io'


class Encrypt < Cryptor
  def initialize(message=nil, *args)
    @message = message
    if args[0] && args[1] && args[2]
      @key = args[0]
      @date = args[1]
      @output = args[2]
    elsif args[0] && args[1]
      @key = args[0]
      @date = args[1]
    elsif
      @output = args[0]
      @key = nil
      @date = nil
    end
  end
  
  def encrypt
    messenger = MessageIO.new(@message)
    if @message.end_with?(".txt")
      @message= messenger.read_file
    end
    rotation = rotation_and_offset
    encrypted = run_the_cipher(rotation)
    unless @output.nil?
    messenger.write_file(@output, encrypted)
    p "Created #{@output} with key of #{key} and date #{date}"
    else 
    encrypted
    end
  end
end

###########################################

# e = Encrypt.new(ARGV[0],ARGV[1])
# e.encrypt