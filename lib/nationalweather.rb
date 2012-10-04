$:.unshift File.dirname(__FILE__)

require 'rexml/document'
require 'nationalweather/current'
require 'nationalweather/forecast'
require 'nationalweather/hazard'

module NationalWeather

  VERSION = '0.1.0'

  def NationalWeather::current(station_id)

  end

  def NationalWeather::forecast(lat, lng, start_date, days)

  end

end