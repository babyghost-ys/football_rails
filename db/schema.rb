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

ActiveRecord::Schema[7.0].define(version: 2022_10_13_152835) do
  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "capital"
    t.string "region"
    t.string "languages"
    t.decimal "population"
    t.float "area"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.text "logo"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_id", null: false
    t.integer "country_id", null: false
    t.index ["country_id"], name: "index_leagues_on_country_id"
    t.index ["type_id"], name: "index_leagues_on_type_id"
  end

  create_table "player_leagues", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_player_leagues_on_league_id"
    t.index ["player_id"], name: "index_player_leagues_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.decimal "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "leagues", "countries"
  add_foreign_key "leagues", "types"
  add_foreign_key "player_leagues", "leagues"
  add_foreign_key "player_leagues", "players"
end
