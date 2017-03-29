require './lib/message_io'
require './lib/crack_message'

class Crack
  attr_reader :input, :output
  
  def initialize(input=nil, output=nil, date=Date.today)
    @input = input
    @output = output  
    @date = date
  end
    def read_file
    messenger = MessageIO.new(@input)
    messenger.read_file
  end

  # def write_file(output, message)
  #   messenger = MessageIO.new
  #   messenger.write_file(output, message)
  # end
  def crack
    c = CrackMessage.new
    c.instantiate_message(read_file, @date)
    confirmation = c.crack
    # write_file(@output,d.to_decrypt.message)
    # p confirmation
  end

end