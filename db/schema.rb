# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_22_114550) do

  create_table "gambles", force: :cascade do |t|
    t.integer "player_id"
    t.integer "round_id"
    t.float "percentage"
    t.float "amount"
    t.integer "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "round_id"], name: "index_gambles_on_player_id_and_round_id", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.float "cash", default: 10000.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_players_on_email", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "color"
    t.integer "winner"
    t.float "total_amount"
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weekly_weathers", force: :cascade do |t|
    t.string "description"
    t.integer "max_temperature"
    t.integer "min_temperature"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
