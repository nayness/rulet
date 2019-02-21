class RoundsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def table
    @round = Round.last || Round.create
    @players = @round.players
    @rounds = Round.order('id DESC').limit(30)
  end

  def infinite_rounds
    @round = Round.last
    render partial: 'round', layout: false, locals: { round: @round }
  end

  def create
    @round = Round.find(params[:round_id])
    @gambles = @round.gambles
    @gambles.each do |gamble|
      percentage = rand(0..8)/100.to_f
      player = Player.find(gamble.player_id)
      gamble.amount = (player.cash * percentage).round(1)
      gamble.color = random_color
      gamble.percentage = percentage
      gamble.save
    end
    @round.color = random_color.to_i
    @round.total_amount = @round.total_bet
    @round.save
    render json: { round_color: @round.color, gambles: @gambles }
  end

  private

  def round_params
    params.require(:round).permit(players: [])
  end
end
