class CreatePlayerGames < ActiveRecord::Migration
  def change
    create_table :player_games do |col|
      col.integer :player_id
      col.integer :game_id
    end
  end
end
