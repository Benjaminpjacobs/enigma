require './lib/message_io'
require './lib/crack_message'

class Crack
  attr_reader :input, :output
  
  def initialize(input=nil, output=nil, date=nil)
    @input = input
    @output = output  
    @date = Date.today if date.nil? 
  end

  def read_file
    messenger = MessageIO.new(@input)
    messenger.read_file
  end
  def write_file(output, message)
    messenger = MessageIO.new
    messenger.write_file(output, message)
  end

  def crack
    c = CrackMessage.new(read_file, @date)
    confirmation = c.crack
    write_file(@output, c.to_crack.message)
    p confirmation
  end

end
##################################
c = Crack.new(ARGV[0], ARGV[1], ARGV[2])
c.crack