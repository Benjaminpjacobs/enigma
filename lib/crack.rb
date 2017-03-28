require "./lib/message_io"
require "./lib/cryptor"
require "./lib/enigma_module"
class Crack < Cryptor
  attr_reader :message, :output, :key, :date

  CI = {'e' => Cipher::CIPHER.index('e'), 
        'n' => Cipher::CIPHER.index('n'), 
        'd' => Cipher::CIPHER.index('d'), 
        '.' => Cipher::CIPHER.index('.')}

  COMPARISON_INDEX = { 4=> [CI["n"], CI["d"], CI["."], CI["."]], 
                       3=> [CI["."], CI["."], CI["e"], CI["n"]],
                       2=> [CI["."], CI["e"], CI["n"], CI["d"]],
                       1=> [CI["e"], CI["n"], CI["d"], CI["."]]
                      }

  def initialize(message=nil, *argument)
    @message = message
    if argument[0] && argument[1] && argument[2]
      @output = argument[0]
      @key = argument[1]
      @date = argument[2]
    elsif argument[0]  && argument[1]
      @output = argument[0]
      @date = argument[1]
    elsif argument[0].is_a?(Fixnum)
      @key = argument[0]
    elsif argument[0].is_a?(Date)
      @date = argument[0]
    elsif argument[0].is_a?(String)
      @output = argument[0]
    end
  end

  def last_group_of_four
    parse_and_split.reverse.find{|sub_array|sub_array.length == 4}
  end

  def comparison_index
    COMPARISON_INDEX[parse_and_split[-1].length]
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
    positive_rotations(rotation)
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

  def crack
    messenger = MessageIO.new(@message)
    if @message.end_with?(".txt")
      @message= messenger.read_file
    end
    message = decrypt
    unless @output.nil?
      messenger.write_file(@output, message)
      p "Created #{@output} with key of #{key_from_date} and date #{date}"
    else 
      p "message: '#{message}', cracked with #{key_from_date} and #{date}"
    end
  end

  def decrypt
    @rotation = find_rotations
    run_the_cipher(@rotation.map{ |num| num * -1 })
  end

  def key_from_date(rotation=@rotation, date=Date.today)
      offset = OffsetGen.new(date)
      offset = offset.convert_into_offset
      split_key = rotation.zip(offset).map! do |sub|
        (sub[0] - sub[1])
      end
      regenerate(split_key.join.split(''))
  end

  def regenerate(num)
    (num[0] + num[1] + num[3] + num[5] + num[7])    
  end

  def read_file
    @message = MessageIO.new(@message).read_file
  end
  
  def write_decrypted_file
    read_file
    MessageIO.new.write_file(@output, crack)
  end
end

######################################
# c = Crack.new(ARGV[0], ARGV[1], ARGV[2])
# c.crack