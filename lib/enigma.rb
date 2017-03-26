require "./lib/encryptor"
require "./lib/key_gen.rb"
require "./lib/offset_gen.rb"
require "./lib/message_io"
require "./lib/crack"
require 'pry'

class Enigma
  def initialize(input=ARGV[0], output=ARGV[1], key=ARGV[2], date=ARGV[3])
    @input = input
    @output = output
    @key = key
    @date = date
  end

  def encrypt(message=@message, key=@key, date=Date.today)
    e = Encryptor.new(message, key, date)
    output = e.crypt("encrypt")
    p "message was encrypted with key #{e.key}. Encrypted message: #{output}"
  end

  def decrypt(message=@message, key=@key, date=Date.today)
    e = Encryptor.new(message, key, date)
    e.crypt("decrypt")
  end

  def crack(message=@message, date=Date.today)
    c = Crack.new(message)
    c.decrypt
  end
end

