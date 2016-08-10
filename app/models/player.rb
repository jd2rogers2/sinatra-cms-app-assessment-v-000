class Player < ActiveRecord::Base
  has_many :player_games
  belongs_to :team
  has_many :games, through: :player_games
  has_many :goals

  has_secure_password
end

# player player player

# team team 

# game

# goal goal goal