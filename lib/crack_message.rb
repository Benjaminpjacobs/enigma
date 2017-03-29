require './lib/message.rb'
require './lib/cryption_module'
require './lib/key_gen'
require './lib/offset_gen'
require './lib/message_io'

class CrackMessage < Cryption
  attr_reader :to_crack

  def initialize
    @to_crack = nil
  end

  def instantiate_message(message, date)
    @to_crack = Message.new(message)
    @to_crack.date = date
  end

  def parse_and_split_message
    messenger = MessageIO.new(@to_crack.message)
    messenger.parse
    @to_crack.message = messenger.split_into_sub_arrays
  end

  def last_group_of_four
    @to_crack.message.reverse.find{|sub_array|sub_array.length == 4}
  end

  def comparison_index
    Cipher::COMPARISON_INDEX[@to_crack.message[-1].length]
  end

  def find_character_indexes
    last_group_of_four.map do |character|
      Cipher::CIPHER.index(character)
    end
  end

  def find_rotations
    a = find_character_indexes
    b = comparison_index
    rotation = a.zip(b).map! do |index|
      (index[0]) - index[1]
    end
    @to_crack.rotation = positive_rotations(rotation)
  end

  def positive_rotations(rotation)
    rotation.map! do |number|
      if number < 0 
        number + Cipher::CIPHER.length 
      else
        number
      end
    end
  end

  def key_from_date
    offset = OffsetGen.new(@to_crack.date)
    offset = offset.convert_into_offset
    split_key = @to_crack.rotation.zip(offset).map! do |sub|
      (sub[0] - sub[1])
    end
    @to_crack.key = regenerate(split_key.join.split(''))
  end
  
  def regenerate(num)
    (num[0] + num[1] + num[3] + num[5] + num[7])    
  end

  def decrypt
    parse_and_split_message
    find_rotations
    rotation = @to_crack.rotation.map{ |num| num * -1 }
    @to_crack.message = run_the_cipher(@to_crack.message, rotation)
  end

  def crack
    decrypt
    key_from_date
    "Message: #{@to_crack.message}. Cracked with key: #{@to_crack.key} and date: #{@to_crack.date.to_s}"
  end
end