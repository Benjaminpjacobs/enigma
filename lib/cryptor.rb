require './lib/key_gen'
require './lib/offset_gen'
require './lib/message_io'
require './lib/enigma_module'

class Cryptor
  attr_accessor :message, :key, :date

  def initialize(message, key = nil, date = nil, output=nil, mode =nil)
    @message = message
    @key = key
    @date = date
    @output = output
    @mode = nil
  end
  
  def parse_and_split
    message = MessageIO.new(@message)
    message.parse
    message.split_into_sub_arrays
  end

  def key_into_rotation
    if key.nil?
      @key = KeyGen.new.generate_original
      offset_key = KeyGen.new.convert_key(key)
    else
      offset_key = KeyGen.new.convert_key(key)
    end
    offset_key
  end
  
  def date_into_offset
    date.nil? ? OffsetGen.new.convert_into_offset : OffsetGen.new(date).convert_into_offset
  end

  def rotation_and_offset
    combo = key_into_rotation.zip(date_into_offset)
    combo.map!{|sub_array| sub_array.inject(&:+)}
  end
  
  def cipher(key, value)
    cipher_array = Cipher::CIPHER.zip(Cipher::CIPHER.rotate(key))
    cipher_hash(cipher_array, value)
  end

  def cipher_hash(array, value)
    cipher_hash = {}
    array.each do |sub_array| 
      cipher_hash[sub_array[0]] = sub_array[1]
    end
    cipher_hash[value]
  end

  def crypt(mode, rotation=nil)
    rotation = rotation_and_offset if rotation.nil?
    parse_and_split.map! do |sub|
      cipher_sub_array(sub, rotation, mode)
    end.join
  end

  def cipher_sub_array(array, rotation, mode)
    array.map!.with_index do |letter, index|
      case index
      when 0
        encrypt_or_decrypt(rotation[0], letter, mode)
      when 1
        encrypt_or_decrypt(rotation[1], letter, mode)
      when 2
        encrypt_or_decrypt(rotation[2], letter, mode)
      else
        encrypt_or_decrypt(rotation[3], letter, mode)
      end
    end
  end 

  def encrypt_or_decrypt(rotation, letter, mode)
    if mode == "encrypt"
      cipher(rotation, letter)
    else
      cipher(-rotation, letter)
    end
  end
end