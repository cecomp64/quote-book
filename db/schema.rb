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

ActiveRecord::Schema.define(version: 20170818042959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "band_names", force: true do |t|
    t.text     "name"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",      default: 0
  end

  add_index "band_names", ["person_id"], name: "index_band_names_on_person_id", using: :btree

  create_table "multi_part_quotes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author"
    t.integer  "score",      default: 0
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_quotes"
  end

  add_index "people", ["num_quotes"], name: "index_people_on_num_quotes", using: :btree

  create_table "quotes", force: true do |t|
    t.text     "text"
    t.integer  "attribution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.integer  "multi_part_quote_id"
    t.text     "context"
  end

  add_index "quotes", ["attribution"], name: "index_quotes_on_attribution", using: :btree

  create_table "quotes_votes", id: false, force: true do |t|
    t.integer "quote_id", null: false
    t.integer "vote_id",  null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "person_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "multi_part_quote_id"
    t.integer  "band_name_id"
  end

  add_index "votes", ["band_name_id"], name: "index_votes_on_band_name_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
