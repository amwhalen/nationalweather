
module NationalWeather

  class Conditions

    attr_reader :summary, :values;

    def initialize(summary, values)
      @summary = summary
      @values = values
    end

    def to_s
      s = @summary
      vals = Array.new
      if @values != nil
        @values.each do |v|
          # TODO: handle "none" for intensity, ex: "patchy none fog"
          # TODO: handle "qualifier"
          if v.has_key?('additive')
            vals.push("#{v['additive']} #{v['coverage']} #{v['intensity']} #{v['weather-type']}")
          else
            vals.push("#{v['coverage']} #{v['intensity']} #{v['weather-type']}")
          end
        end
        s +' (' + vals.join(' ') + ')'
      else
        s
      end
    end

  end

end