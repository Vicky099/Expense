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

ActiveRecord::Schema.define(version: 20160101121126) do

  create_table "expense_categories", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "expense_source", limit: 255
    t.string   "description",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "amount",              limit: 4, default: 0
    t.integer  "user_id",             limit: 4
    t.integer  "expense_category_id", limit: 4
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "income_categories", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "income_source", limit: 255
    t.string   "description",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "income_category_id", limit: 4
    t.integer  "amount",             limit: 4, default: 0
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_records", force: :cascade do |t|
    t.string   "record_name",  limit: 255
    t.integer  "user_id",      limit: 4
    t.integer  "process_id",   limit: 4
    t.string   "process_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "name",                   limit: 255
    t.string   "role",                   limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
