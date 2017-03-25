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

  def rotation_and_offset
    combo = key_into_rotation.zip(date_into_offset)
    combo.map!{|sub_array| sub_array.inject(&:+)}
  end
  
  def cipher(key, value)
    cipher_base = ("0".."z").to_a
    cipher_array = cipher_base.zip(cipher_base.rotate(key))
    cipher_hash(cipher_array, value)
  end

  def cipher_hash(array, value)
    cipher_hash = {}
    array.each do |sub_array| 
      cipher_hash[sub_array[0]] = sub_array[1]
    end
    cipher_hash[value]
  end

  def encrypt
    rotation = rotation_and_offset
    parse
    split_into_sub_arrays.map! do |sub, idx|
      cipher_sub_array(sub, rotation)
    end
  end

  def cipher_sub_array(array, rotation)
    
  end
end