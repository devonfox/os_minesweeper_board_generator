class AddMineLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :mine_locations, :string
  end
end
