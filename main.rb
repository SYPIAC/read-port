# require "serialport"
# port_str = "/dev/ttyACM0"
# baud_rate = 9600
# data_bits = 8
# stop_bits = 1
# parity = SerialPort::NONE
#
# sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
# while true do
#   message = sp.gets
#   if message
#     message.chomp!
#     puts message
#   end
# end


require 'rubyserial'
require 'pry'
require 'mechanize'
POST_URL = "http://localhost/temp"


def actually_float?(val)
  if !val.include? "."
    return false
  end
  begin
    Float(val)
  rescue ArgumentError => e
    return false
  end
  true
end

serialport = Serial.new '/dev/ttyS2', 9600
agent      = Mechanize.new
temp       = ''
loop do
  temp += serialport.read 5
    if actually_float? temp
#      puts temp
      begin
        agent.post POST_URL, { "temp" => temp, "time" => Time.now } 
      rescue Mechanize::ResponseCodeError
        puts String(Time.now) + "/" + temp + " C°\nServer not responding\n"
      end
    end
    temp = ''
end
