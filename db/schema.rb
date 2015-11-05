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

ActiveRecord::Schema.define(version: 20151101000342) do

  create_table "companies", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investments", force: :cascade do |t|
    t.string   "stockName"
    t.string   "ticker"
    t.integer  "quantity"
    t.float    "buyingPrice"
    t.date     "buyingDate"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "portfolio_id"
  end

  add_index "investments", ["portfolio_id"], name: "index_investments_on_portfolio_id"

  create_table "portfolios", force: :cascade do |t|
    t.string   "name"
    t.float    "totalRevenue"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id"

  create_table "stock_search_histories", force: :cascade do |t|
    t.string   "stock"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "ticker"
    t.date     "date"
    t.float    "open_price"
    t.float    "highest_price"
    t.float    "lowest_price"
    t.float    "close_price"
    t.float    "volume"
    t.float    "adj_close"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "term_search_histories", force: :cascade do |t|
    t.string   "term"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
