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

ActiveRecord::Schema[8.0].define(version: 2026_11_24_091653) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.string "category_localized"
    t.string "subcategory"
    t.string "subcategory_localized"
    t.string "category_type"
    t.string "category_type_localized"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_categories_on_organization_id"
  end

  create_table "event_store_events", force: :cascade do |t|
    t.uuid "event_id", null: false
    t.string "event_type", null: false
    t.jsonb "metadata"
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "valid_at"
    t.index "(COALESCE(valid_at, created_at))", name: "index_event_store_events_on_as_of"
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_id"], name: "index_event_store_events_on_event_id", unique: true
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
    t.index ["valid_at"], name: "index_event_store_events_on_valid_at"
  end

  create_table "event_store_events_in_streams", force: :cascade do |t|
    t.string "stream", null: false
    t.integer "position"
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["event_id"], name: "index_event_store_events_in_streams_on_event_id"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "id"], name: "index_event_store_events_in_streams_on_stream_and_id"
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.bigint "billetto_id"
    t.string "object_type"
    t.string "kind"
    t.string "state"
    t.string "title"
    t.text "description"
    t.string "url"
    t.string "branded_url"
    t.string "image_link"
    t.boolean "availability"
    t.integer "minimum_price_cents"
    t.string "minimum_price_currency"
    t.bigint "organizer_id", null: false
    t.bigint "category_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["organization_id"], name: "index_events_on_organization_id"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
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
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_locations_on_event_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.bigint "billetto_id"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billetto_id"], name: "index_organizations_on_billetto_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.bigint "billetto_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billetto_id"], name: "index_organizers_on_billetto_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "direction", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "user_id"], name: "index_votes_on_event_id_and_user_id", unique: true
    t.index ["event_id"], name: "index_votes_on_event_id"
  end

  add_foreign_key "categories", "organizations"
  add_foreign_key "event_store_events_in_streams", "event_store_events", column: "event_id", primary_key: "event_id"
  add_foreign_key "events", "categories"
  add_foreign_key "events", "organizations"
  add_foreign_key "events", "organizers"
  add_foreign_key "locations", "events"
  add_foreign_key "votes", "events"
end
