require 'pry'

class OffsetGen
  attr_accessor :date
  def initialize(date=Date.today)
    @date = date
  end
  
  def convert_into_offset
    date_square = ((@date.strftime("%d%m%y").to_i) ** 2).to_s[-4..-1]
    date_square.split('').map!{|number| number.to_i} 
  end
  
  def previous_date
    @date = @date.prev_day
  end
end