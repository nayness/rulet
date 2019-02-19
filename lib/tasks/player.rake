
namespace :player do
  desc "gambles player cash every 3 min"
  task gambles: :environment do
    players = Player.all
    players.each do |player|
      player.gamble
    end
  end
end
