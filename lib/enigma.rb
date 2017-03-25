require "./lib/encryptor"
require "./lib/key_gen.rb"
require "./lib/offset_gen.rb"
require "./lib/message_io"
require 'pry'

class Enigma
  def initialize(input=ARGV[0], output=ARGV[1], key=ARGV[2], date=ARGV[3])
    @input = input
    @output = output
    @key = key
    @date = date
    # binding.pry
    
  end

  def encrypt(message=@message, key=@key, date=Date.today)
    encrypt = Encryptor.new(message, key, date)
    encrypt.parse_and_split
    output = encrypt.encrypt(encrypt)
    binding.pry
  end

  def decrypt(message=@message, key=@key, date=Date.today)
    
  end

  def crack(message=@message, date=Date.today)
    
  end
end