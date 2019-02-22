namespace :weekly_weather do 
  desc 'fetch  forcast weekly wheather'
  task fetch_max_temperature: :environment do
    forcast = ForcastService.new.fetch_weekly_forcast
    weekly_weather_data = forcast.daily.data
    @weekly_weather = WeeklyWeather.new
    week_max = weekly_weather_data.max_by{ |daily| daily.temperatureMax }
    if week_max
      @weekly_weather.max_temperature = week_max.temperatureMax
      @weekly_weather.min_temperature = week_max.temperatureMin
      @weekly_weather.description = week_max.summary
      
      puts 'Saved Successfully!' if @weekly_weather.save
    end
  end
end