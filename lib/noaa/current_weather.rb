
module NOAA

  class CurrentWeather

    def initialize(xml_string)
      @xml = REXML::Document.new xml_string
    end

    def temperature_f
      value("/current_observation/temp_f").text.to_f
    end

    def temperature_c
      value("/current_observation/temp_c").text.to_f
    end

    def dewpoint_f
      value("/current_observation/dewpoint_f").text.to_f
    end

    def dewpoint_c
      value("/current_observation/dewpoint_c").text.to_f
    end

    def pressure_mb
      value("/current_observation/pressure_mb").text.to_f
    end

    def pressure_inhg
      value("/current_observation/pressure_in").text.to_f
    end

    def relative_humidity
      value("/current_observation/relative_humidity").text.to_i
    end

    def visibility_miles
      value("/current_observation/visibility_mi").text.to_f
    end

    def wind_speed_mph
      value("/current_observation/wind_mph").text.to_f
    end

    def wind_speed_knots
      value("/current_observation/wind_kt").text.to_f
    end

    def wind_degrees
      value("/current_observation/wind_degrees").text.to_i
    end

    def wind_direction
      value("/current_observation/wind_dir").text
    end

    def wind_string
      value("/current_observation/wind_string").text
    end

    def weather
      value("/current_observation/weather").text
    end

    def icon
      base = value("/current_observation/icon_url_base").text
      name = value("/current_observation/icon_url_name").text
      base + name
    end

    def icon_name
      value("/current_observation/icon_url_name").text
    end

    def station_id
      value("/current_observation/station_id").text
    end

    def location
      value("/current_observation/location").text
    end

    def latitude
      value("/current_observation/latitude").text.to_f
    end

    def longitude
      value("/current_observation/longitude").text.to_f
    end

    def time
      value("/current_observation/observation_time_rfc822").text
    end

    private

    def value(xpath_string)
      REXML::XPath.first(@xml, xpath_string)
    end

  end

end