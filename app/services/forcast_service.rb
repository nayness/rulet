class ForcastService
  require 'forecast_io'
  ForecastIO.configure do |configuration|
    configuration.api_key = Figaro.env.forcast_api_key
  end

end