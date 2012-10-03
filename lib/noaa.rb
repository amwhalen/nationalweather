$:.unshift File.dirname(__FILE__)

require 'rexml/document'
require 'noaa/current_weather'

module NOAA

  VERSION = '0.0.1'

  def NOAA::current_weather(station_id)

  end

  def NOAA::forecast(lat, lng, start_date, days)

  end

end