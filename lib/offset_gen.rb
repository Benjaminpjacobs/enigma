require 'pry'

class OffsetGen
  attr_accessor :date
  def initialize(date=Date.today)
    @date = date
  end
  
  def convert_into_offset
    date_square = ((format_date) ** 2).to_s[-4..-1]
    date_square.split('').map!{|number| number.to_i} 
  end
  
  def format_date
    formatted_date = date.to_s.split("-").reverse!
    formatted_date[2] = formatted_date[2][-2..-1]
    formatted_date = formatted_date.join.to_i
  end
  
end