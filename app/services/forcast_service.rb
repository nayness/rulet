class ForcastService
  require 'forecast_io'
  ForecastIO.configure do |configuration|
    configuration.api_key = Figaro.env.forcast_api_key
  end

  def weekly_max_temperatures
    forcast = fetch_weekly_forcast
    weekly_wheater = forcast.daily.data
    weekly_wheater.each_with_object([]) do |daily, max_temperatures|
      if daily.temperatureMax >= 20
        max_temperatures << daily.temperatureMax
      end
    end
  end

  def fetch_weekly_forcast
    date_today = DateTime.now.to_date.to_s
    Rails.cache.fetch("weekly_forcast_#{date_today}", expires_in: 7.days) do
      ForecastIO.forecast(-33.447487, -70.673676, params: { units: 'si' })
    end
  end
end