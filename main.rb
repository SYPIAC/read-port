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
  begin
    Float(val)
  rescue ArgumentError => e
    return false
  end
  true
end

def full_temp?(temp)
  temp != temp.chomp
end

serialport = Serial.new '/dev/ttyS2', 9600
agent      = Mechanize.new
temp       = ''
loop do
  temp += serialport.read 4
  if full_temp? temp
    temp.chomp!
    if actually_float? temp
      puts temp
      agent.post POST_URL, { "temp" => temp}
    end
    temp = ''
  end
   # sleep(1)
end
