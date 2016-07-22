class Team < ActiveRecord::Base
  has_many :team_games
  has_many :players
  has_many :games, through: :team_games
  has_many :goals
end

# player player player

# team team 

# game

# goal goal goal