require "./lib/key_gen"
require "./lib/offset_gen"
require "./lib/message_io"
require "./lib/encrypt"
require "./lib/decrypt"
require "./lib/crack"

class Enigma < Cryptor

  def encrypt(message, key=nil, date=Date.today)
    e = Encrypt.new(message, key, date)
    output = e.encrypt
    p "message was encrypted with key #{e.key}. Encrypted message: #{output}"
  end

  def decrypt(message, key=nil, date=Date.today)
    e = Decrypt.new(message, key, date)
    e.decrypt
  end

  def crack(message, date=Date.today)
    c = Crack.new(message, date)
    c.crack
  end
end

