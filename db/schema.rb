# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_11_21_162116) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.string "category_localized"
    t.string "subcategory"
    t.string "subcategory_localized"
    t.string "category_type"
    t.string "category_type_localized"
    t.bigint "organizer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_categories_on_organizer_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.string "address_line"
    t.string "address_line_2"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.string "country_code"
    t.string "macroregion"
    t.string "region"
    t.string "subregion"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizers", force: :cascade do |t|
    t.bigint "billetto_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billetto_id"], name: "index_organizers_on_billetto_id"
  end

  add_foreign_key "categories", "organizers"
end
