require './lib/message.rb'
require './lib/cryption_module'
require './lib/key_gen'
require './lib/offset_gen'
require './lib/message_io'

class EncryptMessage < Cryption
  include MessageIO
  attr_reader :to_encrypt
  def initialize(message, key=nil, date=Date.today)
    @to_encrypt = Message.new(message, key, date)
  end

  def get_offset
    offset = OffsetGen.new(@to_encrypt.date)
    @to_encrypt.offset = offset.convert_into_offset
  end
  
  def get_rotations
    keygen = KeyGen.new(@to_encrypt.key)
    @to_encrypt.key = keygen.generate_original if @to_encrypt.key.nil?
    @to_encrypt.rotation = keygen.generate
  end
  
  def parse_and_split_message
    message = parse(@to_encrypt.message)
    @to_encrypt.message = split_into_sub_arrays(message)
  end
  
  def encrypt
    get_offset
    get_rotations
    parse_and_split_message
    rotation = rotation_and_offset(@to_encrypt.rotation, @to_encrypt.offset)
    @to_encrypt.message = run_the_cipher(@to_encrypt.message, rotation)
    "Message encrypted with key: #{@to_encrypt.key} and date: #{@to_encrypt.date.to_s}"
  end
end