class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |col|
      col.date :datetime
    end
  end
end
