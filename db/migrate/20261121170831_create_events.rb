class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.bigint :billetto_id
      t.string :object_type
      t.string :kind
      t.string :state
      t.string :title
      t.text :description
      t.string :url
      t.string :branded_url
      t.string :image_link
      t.boolean :availability
      t.integer :minimum_price_cents
      t.string :minimum_price_currency
      t.references :organizer, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
