class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :email
      t.integer :width
      t.integer :height
      t.integer :mine_count
      t.string :board_name

      t.timestamps
    end
  end
end
