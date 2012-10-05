
require File.dirname(__FILE__) + '/../lib/nationalweather'

cw = NationalWeather::current("KBAF")

# display the weather station location and current temp
puts cw.location
puts cw.temperature_f