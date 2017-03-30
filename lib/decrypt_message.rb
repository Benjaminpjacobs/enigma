require './lib/message.rb'
require './lib/cryption_module'
require './lib/key_gen'
require './lib/offset_gen'
require './lib/message_io'

class DecryptMessage 
  include Cryption, MessageIO, KeyGen, OffsetGen
  attr_reader :to_decrypt

  def initialize(message, key, date)
    @to_decrypt = Message.new(message, key, date)
  end

  def get_offset
    @to_decrypt.offset = convert_into_offset(@to_decrypt.date)
  end
  
  def decrypt
    get_offset
    get_rotations
    parse_and_split_message
    rotation = rotation_and_offset(@to_decrypt.rotation, @to_decrypt.offset).map{ |n| n * -1 } 
    @to_decrypt.message = run_the_cipher(@to_decrypt.message, rotation)
    "Message decrypted with key: #{@to_decrypt.key} and date: #{@to_decrypt.date.to_s}"
  end
  
  def get_rotations
    @to_decrypt.rotation = generate(@to_decrypt.key)
  end

  def parse_and_split_message
    message = parse(@to_decrypt.message)
    @to_decrypt.message = split_into_sub_arrays(message)
  end
end