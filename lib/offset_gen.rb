module OffsetGen
  
  def convert_into_offset(date)
    squared_date = date_square(date)
    squared_date.split('').map!{|number| number.to_i} 
  end

  def date_square(date)
    if date.is_a?(Date)
      ((date.strftime("%d%m%y").to_i) ** 2).to_s[-4..-1]
    else
      (date.to_i ** 2).to_s[-4..-1]
    end
  end
end