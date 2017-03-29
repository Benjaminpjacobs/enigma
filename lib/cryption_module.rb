# require './lib/key_gen'
# require './lib/offset_gen'
# require './lib/message_io'
# require './lib/enigma_module'
# require'pry'

# module Cipher
module Cipher

  CIPHER = 
  %w(a b c d e f g h i j k l m 
  n o p q r s t u v w x y z) + 
  %w(0 1 2 3 4 5 6 7 8 9) + 
  [" ", ".", ","] + 
  %w(A B C D E F G H I J K L M 
  N O P Q R S T U V W X Y Z) + 
  %w(! @ # $ % ^ & * ( ) [ ] < 
  > ; : / ? \ | )

  CIPHER_INDEX = {'e' => CIPHER.index('e'), 
      'n' => CIPHER.index('n'), 
      'd' => CIPHER.index('d'), 
      '.' => CIPHER.index('.')}

  COMPARISON_INDEX = { 4=> [CIPHER_INDEX["n"], CIPHER_INDEX["d"], 
                            CIPHER_INDEX["."], CIPHER_INDEX["."]], 
                       3=> [CIPHER_INDEX["."], CIPHER_INDEX["."], 
                            CIPHER_INDEX["e"], CIPHER_INDEX["n"]],
                       2=> [CIPHER_INDEX["."], CIPHER_INDEX["e"], 
                            CIPHER_INDEX["n"], CIPHER_INDEX["d"]],
                       1=> [CIPHER_INDEX["e"], CIPHER_INDEX["n"], 
                            CIPHER_INDEX["d"], CIPHER_INDEX["."]]
                      }
end

class Cryption
    
  def rotation_and_offset(rotation, offset)
    combo = rotation.zip(offset)
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

  def run_the_cipher(message, rotation)
    message.map! do |sub|
      cipher_sub_array(sub, rotation)
    end.join
  end

  def cipher_sub_array(array, rotation)
    array.map!.with_index do |letter, index|
      cipher_sub_array = { 
        0 => cipher(rotation[0], letter),
        1 => cipher(rotation[1], letter),
        2 => cipher(rotation[2], letter),
        3 => cipher(rotation[3], letter),
      }
      cipher_sub_array[index]
    end
  end 
end


