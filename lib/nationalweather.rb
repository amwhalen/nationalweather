$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'rexml/document'
require 'nationalweather/current'
require 'nationalweather/forecast'
require 'nationalweather/hazard'
require 'nationalweather/conditions'
require 'nationalweather/day'

module NationalWeather

  VERSION = '0.1.0'

  def NationalWeather::current(station_id)
    response = fetch("http://www.weather.gov/xml/current_obs/#{station_id}.xml")
    xml = response.body.to_s
    NationalWeather::Current.new(xml)
  end

  # start_date expected in YYYY-MM-DD format
  def NationalWeather::forecast(lat, lng, start_date, days)
    response = fetch("http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=#{lat.to_s}&lon=#{lng.to_s}&format=24+hourly&numDays=#{days.to_s}&startDate=#{start_date}")
    xml = response.body.to_s
    NationalWeather::Forecast.new(xml)
  end

  private

  # Returns the XML response string for the given URL, following redirects along the way
  def NationalWeather::fetch(uri_str, limit = 10)
    # You should choose a better exception.
    raise ArgumentError, 'too many HTTP redirects' if limit == 0

    response = Net::HTTP.get_response(URI(uri_str))

    case response
    when Net::HTTPSuccess then
      response
    when Net::HTTPRedirection then
      location = response['location']
      #warn "redirected to #{location}"
      fetch(location, limit - 1)
    else
      response.value
    end
  end

end