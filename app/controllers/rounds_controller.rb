class RoundsController < ApplicationController

  def table
    @round = Round.new
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
