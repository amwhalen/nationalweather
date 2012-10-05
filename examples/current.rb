
require File.dirname(__FILE__) + '/../lib/nationalweather'

cw = NationalWeather::current("KBAF")

puts cw.location
puts cw.temperature_f