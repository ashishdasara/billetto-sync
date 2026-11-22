class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :category_name
      t.string :category_localized
      t.string :subcategory
      t.string :subcategory_localized
      t.string :category_type
      t.string :category_type_localized
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
