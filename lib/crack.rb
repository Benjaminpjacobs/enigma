require './lib/message_io'
require './lib/crack_message'

class Crack
  include MessageIO
  
  def initialize(input=nil, output=nil, date=nil)
    @input = input
    @output = output  
    @date = date.nil? ? Date.today : date
  end

  def crack
    message = read_file(@input)
    c = CrackMessage.new(message, @date)
    confirmation = c.crack
    write_file(@output, c.to_crack.message)
    p confirmation
  end
end

##################################
c = Crack.new(ARGV[0], ARGV[1], ARGV[2])
c.crack