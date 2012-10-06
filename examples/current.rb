
require File.dirname(__FILE__) + '/../lib/nationalweather'

begin
  cw = NationalWeather.current("KBAF")
  puts cw.location
  puts cw.temperature_f
rescue Exception => e
  abort("There was an error fetching the current weather: #{e.message}")
end
