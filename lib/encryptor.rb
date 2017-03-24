require './lib/key_gen'
require './lib/offset_gen'

require 'pry'
class Encryptor
  attr_accessor :message, :key, :date

  def initialize(message, key = nil, date = nil)
    @message = message
    @key = key
    @date = date
  end
  
  def parse
    @message = message.split('')
  end
  
  def split_into_sub_arrays
    @message = message.each_slice(4).to_a
  end

  def key_into_rotation
    key.nil? ? KeyGen.new.generate : KeyGen.new.convert_key(key)
  end
  
  def date_into_offset
    date.nil? ? OffsetGen.new.convert_into_offset : OffsetGen.new(date).convert_into_offset
  end
  

  # def cipher(key)
  #   cipher_base = ("0".."z").to_a
  #   cipher_base.zip(cipher_base.rotate(@roto_offset[key-1]))
  # end
end