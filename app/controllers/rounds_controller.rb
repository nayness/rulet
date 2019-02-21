class RoundsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def table
    @players = Player.random_players
    @rounds = Round.order('id DESC').limit(30)
  end

  def infinite_rounds
    @round = Round.last
    render partial: 'round', layout: false, locals: { round: @round }
  end

  def create
    @round = Round.create
    @players = Player.where(id: round_params[:players])
    bets = []
    @players.each do |player|
      percentage = rand(0..8)/100.to_f
      amount = (player.cash * percentage).round(1)
      color = random_color
      @gamble = Gamble.new(player_id: player.id, round_id: @round.id,
                amount: amount, percentage: percentage, color: color)
      bets << { amount: amount, color: color } if @gamble.save
    end
    @round.color = random_color
    @round.total_amount = @round.total_bet
    @round.save
    render json: bets.to_json
  end

  private

  def round_params
    params.require(:round).permit(players: [])
  end
end
