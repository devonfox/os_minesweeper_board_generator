class AddMineLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :mine_locations, :integer, array: true, default: []
  end
end
