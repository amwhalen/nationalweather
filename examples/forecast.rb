
require 'time'
require File.dirname(__FILE__) + '/../lib/nationalweather'

# grab the forecast for a certain location
lat = 42.16;
lng = -72.72;
start = Time.now.strftime("%Y-%m-%d")
num_days = 7;

begin
  forecast = NationalWeather.forecast(lat, lng, start, num_days)
rescue Exception => e
  abort("There was an error fetching the forecast: #{e.message}")
end

# display hazards (they're not associated with a day)
forecast.hazards.each { |hazard|
  puts hazard
}

# display the forecast for each day
forecast.days.each{ |day|
  puts "---"
  puts day.start_time.strftime("%A, %b %-d")
  puts day.conditions
  puts "High: #{day.high.to_s}"
  puts "Low: #{day.low.to_s}"
  puts "Precip Day: #{day.precipitation_probability_day} %"
  puts "Precip Night: #{day.precipitation_probability_night} %"
}