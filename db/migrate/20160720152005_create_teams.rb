class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |col|
      col.string :name
    end
  end
end
