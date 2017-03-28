require './lib/cryptor'
require './lib/message_io'
require 'pry'

class Decrypt
  def initialize(input=nil, output=nil, key=nil, date=nil)
    @input = input
    @output = output
    @key = key
    @date = convert_date(date) unless date.nil?
    @mode = :DECRYPT
  end

  def convert_date(date)
    date_split = date.split('').each_slice(2).to_a.map{|sub| sub.join}
    date = Date.new(
      ("20"+ date_split[2].to_s).to_i,
      date_split[1].to_i,
      date_split[0].to_i)
  end

  def decrypt
    messenger = MessageIO.new(@input)
    @input = messenger.read_file
    e = Cryptor.new(@input, @key, @date)
    message = e.crypt(@mode)
    messenger.write_file(@output, message)
    p "Created #{@output} with key of #{e.key} and date #{e.date}"
  end

end

####################################

# d = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
# d.decrypt
