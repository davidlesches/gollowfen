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

ActiveRecord::Schema.define(version: 20131217215724) do

  create_table "favorites", force: true do |t|
    t.integer  "term_id"
    t.datetime "favorited_at"
    t.string   "text"
    t.string   "screen_name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["term_id"], name: "index_favorites_on_term_id"

  create_table "followers", force: true do |t|
    t.integer  "user_id"
    t.string   "screen_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followers", ["user_id"], name: "index_followers_on_user_id"

  create_table "terms", force: true do |t|
    t.integer  "user_id"
    t.string   "term"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "favorites_count", default: 0
    t.integer  "runs",            default: 0
  end

  add_index "terms", ["user_id"], name: "index_terms_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "screen_name"
  end

end
