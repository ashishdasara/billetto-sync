class CreateOrganizers < ActiveRecord::Migration[8.0]
  def change
    create_table :organizers do |t|
      t.bigint :billetto_id
      t.string :name

      t.timestamps
    end
    add_index :organizers, :billetto_id
  end
end
