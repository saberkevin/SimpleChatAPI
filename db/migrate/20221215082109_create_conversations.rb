class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.integer :user_id_from
      t.integer :user_id_to
      t.string :message
      t.boolean :read_status

      t.timestamps
    end
  end
end
