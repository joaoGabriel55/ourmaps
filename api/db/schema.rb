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

ActiveRecord::Schema[7.2].define(version: 2025_02_03_112022) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_map_collaborators", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "custom_map_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_map_id"], name: "index_custom_map_collaborators_on_custom_map_id"
    t.index ["user_id"], name: "index_custom_map_collaborators_on_user_id"
  end

  create_table "custom_maps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.jsonb "content"
    t.uuid "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat_center"
    t.float "lng_center"
    t.string "visibility", default: "public"
    t.index ["owner_id"], name: "index_custom_maps_on_owner_id"
  end

  create_table "custom_maps_users", force: :cascade do |t|
    t.uuid "custom_map_id"
    t.uuid "collaborator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collaborator_id"], name: "index_custom_maps_users_on_collaborator_id"
    t.index ["custom_map_id"], name: "index_custom_maps_users_on_custom_map_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "custom_map_collaborators", "custom_maps"
  add_foreign_key "custom_map_collaborators", "users"
  add_foreign_key "custom_maps", "users", column: "owner_id"
  add_foreign_key "custom_maps_users", "custom_maps"
  add_foreign_key "custom_maps_users", "users", column: "collaborator_id"
end
