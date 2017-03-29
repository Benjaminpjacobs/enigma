require "./lib/encrypt_message"
require "./lib/decrypt_message"
require "./lib/crack_message"
require 'pry'
class Enigma
  def encrypt(message=nil, key=nil, date=Date.today)
    e = EncryptMessage.new
    e.instantiate_message(message, key, date)
    e.encrypt
    e.to_encrypt.message
  end

  def decrypt(message=nil, key=nil, date=Date.today)
    d = DecryptMessage.new
    d.instantiate_message(message, key, date)
    d.decrypt
    d.to_decrypt.message
  end
  
  def crack(message=nil, date=Date.today)
    c = CrackMessage.new
    c.instantiate_message(message, date)
    c.crack
    c.to_crack.message
  end
end