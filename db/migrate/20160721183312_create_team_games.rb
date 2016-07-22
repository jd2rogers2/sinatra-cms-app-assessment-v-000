class CreateTeamGames < ActiveRecord::Migration
  def change
    create_table :team_games do |col|
      col.integer :team_id
      col.integer :game_id
    end
  end
end
