class RoundsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def table
    @round = Round.last || Round.create
    @players = @round.players
    @rounds = Round.order('id DESC').limit(30).offset(1)
    @weekly_weather = @round.weekly_weather
  end

  def infinite_rounds
    @round = Round.find(params[:round_id])
    render partial: 'round', layout: false, locals: { round: @round }
  end

  def create
    @round = Round.find(params[:round_id])
    @gambles = @round.gambles
    @gambles.each do |gamble|
      player = Player.find(gamble.player_id)
      percentage = player.bet_percentage(@round.weekly_weather)
      gamble.amount = (player.cash * percentage).round(1)
      gamble.color = random_color
      gamble.percentage = percentage
      gamble.save
    end
    @round.color = random_color
    @round.total_amount = @round.total_bet
    @round.wins
    @round.save
    @round.gambles << @gambles
    @new_round = Round.create
    render json: { round_color: @round.color, gambles: @gambles, new_round: @new_round.id}
  end

  private

  def round_params
    params.require(:round).permit(players: [])
  end
end
