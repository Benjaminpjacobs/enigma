require "./lib/message_io"
# require "./lib/key_gen"
# require "./lib/off_set"
# require "./lib/encryptor"
require 'pry'

class Crack
  attr_reader :message, :key, :date
  CIPHER_BASE = ("0".."z").to_a.push('!', "#", "$", "%", "&",                                   "*", "(", ")", ".", "/",                                   "|", ",", " ")

  CRACK_INDEXES = {'e' => 53, "n" => 62, 
                   'd' => 52, '.' => 83}

  def initialize(message=nil, *key_date)
    @message = message
    if key_date[1]
      @key = key_date[0]
      @date = key_date[1]
    elsif key_date[0].is_a?(Fixnum)
      @key = key_date[0]
    elsif key_date[0].is_a?(Date)
      @date = key_date[0]
    end
  end

  def parse_and_split
    m = MessageIO.new(@message)
    m.parse
    m.split_into_sub_arrays
    
  end

  def last_group_of_four
    parse_and_split.reverse.find{|sub_array|sub_array.length == 4}
  end

  def comparison_index
    case parse_and_split[-1].length
    when 4
      [62, 52, 83, 83]
    when 3
      [83, 83, 53, 62]
    when 2
      [83, 53, 62, 52]
    when 1
      [53, 62, 52, 83]
    end
  end
  
  def find_character_indexes
    last_group_of_four.map do |character|
      CIPHER_BASE.index(character)
    end
  end

  def find_rotations
    a = find_character_indexes
    b = comparison_index
    binding.pry
    a.zip(b).map! do |index|
      (index[0] + 88) - index[1]
    end
  end

  def decrypt
    rotation = find_rotaions
    e = Encryptor.new(message)
    e.crypt(decrypt,rotation)
  end

end