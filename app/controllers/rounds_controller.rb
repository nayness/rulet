class RoundsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def table
    @players = Player.random_players
  end

  def create
    @round = Round.create
    @players = Player.where(id: round_params[:players])
    bets = []
    @players.each do |player|
      percentage = rand(0..8)/100.to_f
      amount = (player.cash * percentage).round(1)
      color = player.random_color
      @gamble = Gamble.new(player_id: player.id, round_id: @round.id,
                amount: amount, percentage: percentage, color: color)
      bets << { amount: amount, color: color } if @gamble.save
    end
    render json: bets.to_json
  end

  private

  def round_params
    params.require(:round).permit(players: [])
  end
end
