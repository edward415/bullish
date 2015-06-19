# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150618074427) do

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.boolean  "buy"
    t.integer  "qty"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "initiate"
    t.boolean  "close"
  end

  add_index "events", ["stock_id"], name: "index_events_on_stock_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "histories", force: true do |t|
    t.decimal  "gain"
    t.integer  "stock_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "pct_gain"
    t.integer  "event_id"
    t.string   "histories"
    t.decimal  "buy_price"
    t.decimal  "sell_price"
    t.datetime "initiate_date"
  end

  add_index "histories", ["stock_id"], name: "index_histories_on_stock_id"
  add_index "histories", ["user_id"], name: "index_histories_on_user_id"

  create_table "holdings", force: true do |t|
    t.integer  "qty"
    t.datetime "initiate_time"
    t.integer  "stock_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.decimal  "gain_now"
    t.decimal  "initial_value"
  end

  add_index "holdings", ["stock_id"], name: "index_holdings_on_stock_id"
  add_index "holdings", ["user_id"], name: "index_holdings_on_user_id"

  create_table "stocks", force: true do |t|
    t.string   "symbol"
    t.string   "name"
    t.float    "last"
    t.string   "date"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "market_identification_code"
    t.integer  "user_id"
    t.float    "high"
    t.float    "low"
    t.float    "close"
    t.float    "high52_weeks"
    t.float    "low52_weeks"
    t.integer  "volume"
    t.float    "start"
    t.float    "ask"
    t.float    "bid"
  end

  add_index "stocks", ["user_id"], name: "index_stocks_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "picture"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
