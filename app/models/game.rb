class Game < ActiveRecord::Base
  has_many :player_games
  has_many :team_games
  has_many :teams, through: :team_games
  has_many :players, through: :player_games
  has_many :goals
end

# player player player

# team team 

# game

# goal goal goal