require "./lib/message_io"
require "./lib/cryptor"
require "./lib/enigma_module"

class Crack
  attr_reader :message, :key, :date

  CI = {'e' => 4, "n" => 13, 
        'd' => 3, '.' => 37}

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
      [CI["n"], CI["d"], CI["."], CI["."]]
    when 3
      [CI["."], CI["."], CI["e"], CI["n"]]
    when 2
      [CI["."], CI["e"], CI["n"], CI["d"]]
    when 1
      [CI["e"], CI["n"], CI["d"], CI["."]]
    end
  end
  
  def find_character_indexes
    last_group_of_four.map do |character|
      Cipher::CIPHER.index(character)
    end
  end

  def find_rotations
    a = find_character_indexes
    b = comparison_index
    a.zip(b).map! do |index|
      (index[0]) - index[1]
    end
  end

  def decrypt
    rotation = find_rotations
    e = Cryptor.new(message)
    e.crypt("decrypt", rotation)
  end

end