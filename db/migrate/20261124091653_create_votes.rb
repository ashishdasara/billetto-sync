class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.string :user_id, null: false
      t.string :direction, null: false
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end

    add_index :votes, [ :event_id, :user_id ], unique: true
  end
end
