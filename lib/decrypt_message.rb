require './lib/message.rb'
require './lib/cryption_module'
require './lib/key_gen'
require './lib/offset_gen'
require './lib/message_io'

class DecryptMessage < Cryption
  attr_reader :to_decrypt
  def initialize(message, key, date)
    @to_decrypt = Message.new(message, key, date)
  end

  def get_offset
    offset = OffsetGen.new(@to_decrypt.date)
    @to_decrypt.offset = offset.convert_into_offset
  end
  
  def get_rotations
    keygen = KeyGen.new(@to_decrypt.key)
    @to_decrypt.rotation = keygen.generate
  end

  def parse_and_split_message
    messenger = MessageIO.new(@to_decrypt.message)
    messenger.parse
    @to_decrypt.message = messenger.split_into_sub_arrays
  end
  
  def decrypt
    get_offset
    get_rotations
    parse_and_split_message
    rotation = rotation_and_offset(@to_decrypt.rotation, @to_decrypt.offset).map{ |n| n * -1 } 
    @to_decrypt.message = run_the_cipher(@to_decrypt.message, rotation)
    "Message decrypted with key: #{@to_decrypt.key} and date: #{@to_decrypt.date.to_s}"
  end

end

