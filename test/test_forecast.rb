require 'test/unit'
require File.dirname(__FILE__) + '/../lib/nationalweather'

class TestForecast < Test::Unit::TestCase
  
  def test_7day
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
    assert_equal("long duration Lake Wind Advisory", hazard.to_s)

    # conditions
    expectedConditionsSummaries = [
      'Snow Likely',
      'Snow Likely',
      'Chance Snow',
      'Slight Chance Snow',
      'Mostly Cloudy',
      'Chance Snow',
      'Mostly Cloudy'
    ]
    expectedConditionsStrings = [
      'Snow Likely (likely light snow)',
      'Snow Likely (likely light snow)',
      'Chance Snow (chance light snow)',
      'Slight Chance Snow (slight chance light snow)',
      'Mostly Cloudy',
      'Chance Snow (chance light snow)',
      'Mostly Cloudy'
    ]
    i = 0
    f.conditions.each do |c|
      assert_equal(expectedConditionsSummaries[i], c.summary)
      assert_equal(expectedConditionsStrings[i], c.to_s)
      i += 1
    end

    # days
    7.times do |i|
      day = f.day(i)
      assert_not_nil(day)
      assert_equal(expectedHighs[i], day.high)
      assert_equal(expectedLows[i], day.low)
      assert_equal(expectedIcons[i], day.icon)
      assert_equal(expectedStartTimes[i], day.start_time)
      assert_equal(expectedEndTimes[i], day.end_time)
      assert_equal(expectedConditionsSummaries[i], day.conditions.summary)
      assert_equal(expectedConditionsStrings[i], day.conditions.to_s)
      assert_equal(expectedPrecipitation[i*2], day.precipitation_probability_day)
      assert_equal(expectedPrecipitation[i*2+1], day.precipitation_probability_night)
    end

  end

  def test_conditions

    f = NationalWeather::Forecast.new(File.new(File.dirname(__FILE__) + "/xml/forecast_conditions.xml"))

    # conditions
    expectedConditionsSummaries = [
      'Chance Rain Showers',
      'Partly Sunny',
      'Chance Rain Showers',
      'Chance Rain Showers',
      'Slight Chance Rain Showers',
      'Slight Chance Rain Showers',
      'Slight Chance Rain Showers'
    ]
    expectedConditionsStrings = [
      'Chance Rain Showers (chance light rain showers and patchy none fog)',
      'Partly Sunny',
      'Chance Rain Showers (chance light rain showers)',
      'Chance Rain Showers (chance light rain showers)',
      'Slight Chance Rain Showers (slight chance light rain showers)',
      'Slight Chance Rain Showers (slight chance light rain showers)',
      'Slight Chance Rain Showers (slight chance light rain showers)'
    ]
    i = 0
    f.conditions.each do |c|
      assert_equal(expectedConditionsSummaries[i], c.summary)
      assert_equal(expectedConditionsStrings[i], c.to_s)
      i += 1
    end

  end

end