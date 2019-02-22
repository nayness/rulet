class ForcastService
  require 'forecast_io'
  ForecastIO.configure do |configuration|
    configuration.api_key = Figaro.env.forcast_api_key
  end

  def weekly_max_temperatures
    forcast = ForecastIO.forecast(-33.447487, -70.673676, params: { units: 'si' })
    weekly_wheater = forcast.daily.data
    weekly_wheater.each_with_object([]) do |daily, max_temperatures|
      if daily.temperatureMax >= 20
        max_temperatures << daily.temperatureMax
      end
    end
  end
end