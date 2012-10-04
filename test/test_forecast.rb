require 'test/unit'
require File.dirname(__FILE__) + '/../lib/nationalweather'

class TestForecast < Test::Unit::TestCase
  
  def test_values
    f = NationalWeather::Forecast.new(File.new(File.dirname(__FILE__) + "/xml/forecast_7day.xml"))
    
    # length of forecast
    assert_equal(7, f.length)

    # high temps
    expectedHighs = [38, 29, 33, 20, 37, 18, 14]
    assert_equal(expectedHighs, f.high_temperatures)

    # low temps
    expectedLows = [17, 19, 20, 14, 14, 2, nil]
    assert_equal(expectedLows, f.low_temperatures)

    # precipitation
    expectedPrecipitation = [27, 19, 56, 33, 30, 27, 20, 7, 10, 16, 26, 12, 11, nil]
    assert_equal(expectedPrecipitation, f.precipitation_probabilities)

    # icons
    expectedIcons = [
      'http://www.nws.noaa.gov/weather/images/fcicons/sn30.jpg',
      'http://www.nws.noaa.gov/weather/images/fcicons/sn60.jpg',
      'http://www.nws.noaa.gov/weather/images/fcicons/sn30.jpg',
      'http://www.nws.noaa.gov/weather/images/fcicons/sn20.jpg',
      'http://www.nws.noaa.gov/weather/images/fcicons/bkn.jpg',
      'http://www.nws.noaa.gov/weather/images/fcicons/sn30.jpg',
      'http://www.nws.noaa.gov/weather/images/fcicons/bkn.jpg'
    ]
    assert_equal(expectedIcons, f.icons)

    # start times
    expectedStartTimes = [
      '2008-12-05T06:00:00-07:00',
      '2008-12-06T06:00:00-07:00',
      '2008-12-07T06:00:00-07:00',
      '2008-12-08T06:00:00-07:00',
      '2008-12-09T06:00:00-07:00',
      '2008-12-10T06:00:00-07:00',
      '2008-12-11T06:00:00-07:00'
    ].map {|t| Time.parse(t) }
    assert_equal(expectedStartTimes, f.start_times)

    # end times
    expectedEndTimes = [
      '2008-12-06T06:00:00-07:00',
      '2008-12-07T06:00:00-07:00',
      '2008-12-08T06:00:00-07:00',
      '2008-12-09T06:00:00-07:00',
      '2008-12-10T06:00:00-07:00',
      '2008-12-11T06:00:00-07:00',
      '2008-12-12T06:00:00-07:00'
    ].map {|t| Time.parse(t) }
    assert_equal(expectedEndTimes, f.end_times)

    # hazards
    expectedHazard = NationalWeather::Hazard.new(
      "LW.Y",
      "Lake Wind",
      "Advisory",
      "long duration",
      "http://forecast.weather.gov/wwamap/wwatxtget.php?cwa=usa&wwa=Lake%20Wind%20Advisory"
    )
    # returns an array, but there's only one in this test
    hazard = f.hazards[0]
    assert_equal(expectedHazard.code, hazard.code)
    assert_equal(expectedHazard.phenomena, hazard.phenomena)
    assert_equal(expectedHazard.significance, hazard.significance)
    assert_equal(expectedHazard.type, hazard.type)
    assert_equal(expectedHazard.url, hazard.url)

    # conditions
    

  end

end