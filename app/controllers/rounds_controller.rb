class RoundsController < ApplicationController
  before_action :set_current_round, only: [:table, :create, :winners, :gamble]

  def table
    @players = @round.players
    @rounds = Round.closed
    @weekly_weather = @round.weekly_weather
    @gambles = @round.winners
  end

  def infinite_rounds
    @round = Round.closed.first
    render partial: 'round', layout: false, locals: { round: @round }
  end

  def create
    @round.state = 1
    if @round.save
      Round.create
      render json: {}, status: :ok
    else
      render json: @round.errors, status: :unprocessable_entity
    end
  end

  def winners
    @round.color = @round.random_color
    @round.total_amount = @round.total_bet
    @round.wins
    @round.save
    @gambles = @round.winners
    render partial: 'players/winners', layout: false, locals: { gambles: @gambles, round: @round }
  end

  def gamble
    @gambles = @round.gambles
    @gambles.each do |gamble|
      player = Player.find(gamble.player_id)
      percentage = player.bet_percentage(@round.weekly_weather)
      gamble.amount = (player.cash * percentage).round(1)
      gamble.color = player.random_color
      gamble.percentage = percentage
      gamble.save
    end
    render json: { gambles: @gambles }
  end


  def last_round
    @round = Round.closed.first
    render json: { color: @round.color }
  end

  private

  def set_current_round
    @round = Round.open.last  || Round.create
  end
  def round_params
    params.require(:round).permit(players: [])
  end
end
