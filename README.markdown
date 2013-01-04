NationalWeather
===============

NationalWeather is a Ruby client library for the National Oceanic and Atmospheric Administration's (NOAA) National Weather Service (NWS) forecast and current weather services.

Current weather data is provided by [NOAA's XML Feeds of Current Weather Conditions](http://w1.weather.gov/xml/current_obs/).
Forecast data is provided by the [NOAA's National Digital Forecast Database (NDFD) REST Web Service](http://graphical.weather.gov/xml/rest.php).
NOAA is a United States federal agency, so the data they provide is only available for US locations.

Installation
------------

It's as simple as:

	gem install nationalweather

Current Weather Conditions
--------------------------

To find your current weather conditions you'll first need to know a local NOAA Weather Observation Station ID.
You can search for your local station ID here: http://www.weather.gov/xml/current_obs/.
There is also a list of stations in XML if you'd like to do something with the station data: http://www.weather.gov/xml/current_obs/index.xml.
Here is some sample code for getting the current weather conditions:

	require 'nationalweather'

	begin
	  cw = NationalWeather.current("KBAF")
	  puts cw.location
	  puts cw.temperature_f
	rescue Exception => e
	  puts "There was an error fetching the current weather: #{e.message}"  
	end

Forecast
--------

A latitude and longitude are required to retrieve forecast data.
There are many APIs that will convert addresses and zip codes into latitude and longitude, but those conversions are outside the scope of this library.
The data provided by the API is 24-hour summarized data from 6am-6pm (local time for the supplied location).
The precipitation probabilities provided are 12-hour summaries for day and night, running from 6am-6pm and 6pm-6am respectively.
Depending on the time of day you make the request (local to the location you request), the first day included in the response may be "today" or "tomorrow".
Here is some sample code for getting the 7-day forecast starting from the current time:

    require 'time'
	require 'nationalweather'

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

Caching
-------

NOAA suggests that consumers of their API ask for new data only once per hour.
