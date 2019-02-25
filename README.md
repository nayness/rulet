# README

This is a demo simulation of a monitoring system in a casino for rulet players. The rulet spins automatically every 3 mins, players make their bets and winners of each round are shown once the round ends in the main page.

## Getting Started

First you must create a file application.yml manually and add it to config folder or

     $ bundle exec figaro install

Then you'll need to create an account at https://darksky.net/dev and add your api key in application.yml
    
    forcast_api_key: 'YOUR_KEY_HERE'

Finally run the task

    $ rake weekly_weather:fetch_max_temperature

* Ruby version 2.5.3

