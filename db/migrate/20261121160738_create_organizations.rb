class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.bigint :billetto_id
      t.string :domain

      t.timestamps
    end
    add_index :organizations, :billetto_id
  end
end
