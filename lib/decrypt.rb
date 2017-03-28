require './lib/cryptor'
require './lib/message_io'
require 'pry'

class Decrypt < Cryptor
  def initialize(message=nil, output=nil, key=nil, date=nil)
    @message = message
    @output = output
    @key = key
    @date = convert_date(date) unless date.nil?
  end

  def convert_date(date)
    date_split = date.split('').each_slice(2).to_a.map{|sub| sub.join}
    date = Date.new(
      ("20"+ date_split[2].to_s).to_i,
      date_split[1].to_i,
      date_split[0].to_i)
  end

  def decrypt
    messenger = MessageIO.new(@message)
    @message = messenger.read_file
    rotation = rotation_and_offset
    decrypted  = run_the_cipher(rotation.map!{|num| num * -1})
    messenger.write_file(@output, decrypted)
    p "Created #{@output} with key of #{key} and date #{date}"
  end

end

####################################

# d = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
# d.decrypt
