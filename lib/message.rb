require "Date"

class Message
  attr_accessor :message, :key, :date, :rotation, :offset

  def initialize(message=nil, key=nil, date=Date.today, rotation=nil, offset=nil)
    @message = message
    @key = key
    @date = date
    @rotation = rotation
    @offset = offset
  end
end