class RoundsController < ApplicationController

  def table
    @round = Round.new
    @players = Player.random_players
  end

  def create
    @round = Round.new(round_params)
    if @round.save
      
      players = Player.random_players
      players.each do |player|
        player.gamble
      end
    end
  end
end
