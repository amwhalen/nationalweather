Gem::Specification.new do |s|
  s.name        = 'nationalweather'
  s.version     = '0.1.2'
  s.date        = '2016-02-15'
  s.summary     = "Client library for NOAA's forecast and current weather services."
  s.description = "NationalWeather is a Ruby client library for the National Oceanic and Atmospheric Administration's (NOAA) National Weather Service (NWS) forecast and current weather REST web services."
  s.authors     = ["Andrew M. Whalen"]
  s.email       = 'nationalweather-ruby@amwhalen.com'
  s.files       = ['lib/nationalweather.rb', 'lib/nationalweather/conditions.rb', 'lib/nationalweather/current.rb', 'lib/nationalweather/day.rb', 'lib/nationalweather/forecast.rb', 'lib/nationalweather/hazard.rb']
  s.test_files  = ['test/test_current.rb', 'test/test_forecast.rb']
  s.homepage    = 'https://github.com/amwhalen/nationalweather'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 1.8.6'
end