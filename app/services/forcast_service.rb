class ForcastService
  require 'forecast_io'
  ForecastIO.configure do |configuration|
    configuration.api_key = Figaro.env.forcast_api_key
  end

  def fetch_weekly_forcast
    date_today = DateTime.now.to_date.to_s
    ForecastIO.forecast(-33.447487, -70.673676, params: { units: 'si' })
  end
end