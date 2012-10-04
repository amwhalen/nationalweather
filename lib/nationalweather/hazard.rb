
module NationalWeather

  class Hazard

    attr_reader :code, :phenomena, :significance, :type, :url;

    def initialize(code, phenomena, significance, type, url)
      @code = code
      @phenomena = phenomena
      @significance = significance
      @type = type
      @url = url
    end

  end

end