
require 'time'

module NationalWeather

  class Forecast

    def initialize(xml_string)
      @xml = REXML::Document.new xml_string
      @values = Hash.new
      @days = Array.new
    end

    def length
      start_times.length
    end

    def high_temperatures
      values('/dwml/data[1]/parameters[1]/temperature[@type="maximum"][1]/value', 'high_temperatures') {|node| node.to_i }
    end

    def low_temperatures
      values('/dwml/data[1]/parameters[1]/temperature[@type="minimum"][1]/value', 'low_temperatures') {|node| node.to_i }
    end

    def precipitation_probabilities
      values('/dwml/data[1]/parameters[1]/probability-of-precipitation[1]/value', 'precipitation_probabilities') {|node| node.to_i }
    end

    def start_times
      values('/dwml/data[1]/time-layout[@summarization="24hourly"][1]/start-valid-time', 'start_times') {|node| Time.parse(node) }
    end

    def end_times
      values('/dwml/data[1]/time-layout[@summarization="24hourly"][1]/end-valid-time', 'end_times') {|node| Time.parse(node) }
    end

    def icons
      values('/dwml/data[1]/parameters[1]/conditions-icon[1]/icon-link', 'icons')
    end

    # Returns any Hazards (Watches, Warnings, and Advisories) for the forecast time period.
    #
    # SINGLE:
    #   <hazard hazardCode="LW.Y" phenomena="Lake Wind" significance="Advisory" hazardType="long duration">
    #     <hazardTextURL>http://forecast.weather.gov/wwamap/wwatxtget.php?cwa=usa&amp;wwa=Lake%20Wind%20Advisory</hazardTextURL>
    #   </hazard>
    #
    # EMPTY:
    #   <hazard-conditions xsi:nil="true"/>
    def hazards
      if !@values.has_key?('hazards')
        @values['hazards'] = REXML::XPath.match(@xml, '/dwml/data[1]/parameters[1]/hazards[1]/hazard-conditions[1]/hazard').map {|node|
          # handle empty nodes like <hazards-conditions xsi:nil="true" />
          if node.has_elements?
            code = node.attributes["hazardCode"]
            phenomena = node.attributes["phenomena"]
            significance = node.attributes["significance"]
            type = node.attributes["hazardType"]
            url = node.get_elements("hazardTextURL")[0].text
            NationalWeather::Hazard.new(code, phenomena, significance, type, url)
          else
            nil
          end
        }
      end
      @values['hazards']
    end

    private

    # Returns an Array of values for the given XPath query.
    # A block to format each value String can be included with the call to this method.
    # If no block is given the values in the Array will be Strings.
    # This method cached the result so it doesn't need to query the XML and format the nodes each time it's called
    def values(xpath_string, key)
      if !@values.has_key?(key)
        @values[key] = REXML::XPath.match(@xml, xpath_string).map {|node|
          # handle empty nodes like <value xsi:nil="true" />
          if node.has_text?
            if block_given?
              # format the String with the supplied block
              yield(node.text)
            else
              # default: return a String
              node.text
            end
          else
            nil
          end
        }
      end
      @values[key]
    end

  end

end