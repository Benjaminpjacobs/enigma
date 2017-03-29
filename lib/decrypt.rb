require './lib/message_io'
require './lib/decrypt_message'

class Decrypt
  include MessageIO
  attr_reader :input, :output
  
  def initialize(input=nil, output=nil, key=nil, date=Date.today)
    @input = input
    @output = output  
    @key = key
    @date = date

  end

  def decrypt
    message = read_file(@input)
    d = DecryptMessage.new(message, @key, @date)
    confirmation = d.decrypt
    write_file(output,d.to_decrypt.message)
    p confirmation
  end
end

#######################
# d = Decrypt.new(ARGV[0], ARGV[1], ARGV[2])
# d.decrypt