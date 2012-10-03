require 'test/unit'
require File.dirname(__FILE__) + '/../lib/noaa'

class TestCurrentWeather < Test::Unit::TestCase
  
  def test_values
    cw = NOAA::CurrentWeather.new(File.new("current_KBAF.xml"))
    
    assert_equal(62.0, cw.temperature_f)
    assert_equal(16.7, cw.temperature_c)

    assert_equal(50.0, cw.dewpoint_f)
    assert_equal(10.0, cw.dewpoint_c)

    assert_equal(1007.2, cw.pressure_mb)
    assert_equal(29.74, cw.pressure_inhg)

    assert_equal(65, cw.relative_humidity)

    assert_equal(10.0, cw.visibility_miles);

    assert_equal(0.0, cw.wind_speed_mph)
    assert_equal(0.0, cw.wind_speed_knots)
    assert_equal(0.0, cw.wind_degrees)
    assert_equal("North", cw.wind_direction)
    assert_equal("Calm", cw.wind_string)

    assert_equal("Overcast", cw.weather)

    assert_equal("http://w1.weather.gov/images/fcicons/ovc.jpg", cw.icon)
    assert_equal("ovc.jpg", cw.icon_name)

    assert_equal("KBAF", cw.station_id)

    assert_equal("Westfield, Barnes Municipal Airport, MA", cw.location)

    assert_equal(42.16, cw.latitude)

    assert_equal(-72.72, cw.longitude)

    assert_equal("Sun, 30 Sep 2012 14:53:00 -0400", cw.time)
  end

end