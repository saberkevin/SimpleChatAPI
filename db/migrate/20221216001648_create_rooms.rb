class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :user_id_1
      t.integer :user_id_2

      t.timestamps
    end
  end
end
