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

ActiveRecord::Schema.define(version: 20181015032002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borrowers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "contact_num"
    t.string   "relation_with_payer"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_borrowers_on_user_id", using: :btree
  end

  create_table "expense_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "expense_source"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "amount",              default: 0
    t.integer  "user_id"
    t.integer  "expense_category_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "refundable"
    t.string   "removed",             default: "NO"
    t.integer  "remain_amount",       default: 0
    t.integer  "borrower_id"
    t.index ["borrower_id"], name: "index_expenses_on_borrower_id", using: :btree
  end

  create_table "income_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "income_source"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "income_category_id"
    t.integer  "amount",             default: 0
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "amount_type",        default: "0"
    t.integer  "expense_id"
    t.string   "refund_type"
  end

  create_table "transaction_records", force: :cascade do |t|
    t.string   "record_name"
    t.integer  "user_id"
    t.integer  "process_id"
    t.string   "process_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
