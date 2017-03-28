class OffsetGen
  attr_accessor :date
  def initialize(date=Date.today)
    @date = date
  end
  
  def convert_into_offset
    date = date_square
    date = date.split('').map!{|number| number.to_i} 
  end

  def date_square
    if @date.is_a?(Date)
      ((@date.strftime("%d%m%y").to_i) ** 2).to_s[-4..-1]
    else
      (@date.to_i ** 2).to_s[-4..-1]
    end
  end
  
  def previous_date
    @date = @date.prev_day
  end
end