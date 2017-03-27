require "./lib/cryptor"
require "./lib/key_gen"
require "./lib/offset_gen"
require "./lib/message_io"
require "./lib/crack"

class Enigma

  def encrypt(message=@message, key=@key, date=Date.today)
    e = Cryptor.new(message, key, date)
    output = e.crypt(:ENCRYPT)
    p "message was encrypted with key #{e.key}. Encrypted message: #{output}"
  end

  def decrypt(message=@message, key=@key, date=Date.today)
    e = Cryptor.new(message, key, date)
    e.crypt(:DECRYPT)
  end

  def crack(message=@message, date=Date.today)
    c = Crack.new(message)
    c.decrypt
  end
end

