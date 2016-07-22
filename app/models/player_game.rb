class PlayerGame < Sinatra::Base
  belongs_to :game
  belongs_to :player
end