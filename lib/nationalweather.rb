$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'rexml/document'
require 'nationalweather/current'
require 'nationalweather/forecast'
require 'nationalweather/hazard'
require 'nationalweather/conditions'
require 'nationalweather/day'

module NationalWeather

  VERSION = '0.1.1'

  # Returns the current weather conditions at the station id specified, or nil if there was an error.
  # For the station ID see: http://www.weather.gov/xml/current_obs/
  # XML list of stations: http://www.weather.gov/xml/current_obs/index.xml
  def NationalWeather::current(station_id)
    xml = fetch("http://www.weather.gov/xml/current_obs/#{station_id}.xml")
    NationalWeather::Current.new(xml)
  end

  # Returns the forecast for the given location, or nil if there was an error.
  # start_date expected in YYYY-MM-DD format
  def NationalWeather::forecast(lat, lng, start_date, days)
    xml = fetch("http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=#{lat.to_s}&lon=#{lng.to_s}&format=24+hourly&numDays=#{days.to_s}&startDate=#{start_date}")
    NationalWeather::Forecast.new(xml)
  end

  # raised if there are too many redirects while fetching the weather response
  class TooManyRedirectsError < StandardError
  end

  # raised if the API server does not return an HTTP success code
  class BadHTTPResponseError < StandardError
  end

  private

  # Returns the XML response string for the given URL, following redirects along the way
  def NationalWeather::fetch(uri_str, limit = 10)

    # TODO: optional file cache

    raise NationalWeather::TooManyRedirectsError, 'Too many HTTP redirects.' if limit == 0

    response = Net::HTTP.get_response(URI(uri_str))

    case response
    when Net::HTTPSuccess then
      response.body.to_s
    when Net::HTTPRedirection then
      location = response['location']
      fetch(location, limit - 1)
    else
      raise NationalWeather::BadHTTPResponseError, "Bad return value: #{response.value}"
    end
  end

end