class TeamGame < Sinatra::Base
  belongs_to :team
  belongs_to :game
end