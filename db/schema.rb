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

ActiveRecord::Schema.define(version: 20140711045607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_stats", force: true do |t|
    t.integer  "user_id"
    t.integer  "ap"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "import_date"
    t.string   "name"
  end

  add_index "agent_stats", ["import_date"], name: "index_agent_stats_on_import_date", using: :btree
  add_index "agent_stats", ["user_id"], name: "index_agent_stats_on_user_id", using: :btree

  create_table "agent_stats_entries", force: true do |t|
    t.integer  "agent_stat_id"
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agent_stats_entries", ["agent_stat_id"], name: "index_agent_stats_entries_on_agent_stat_id", using: :btree
  add_index "agent_stats_entries", ["name"], name: "index_agent_stats_entries_on_name", using: :btree

  create_table "agent_stats_uploads", force: true do |t|
    t.integer  "agent_stat_id"
    t.integer  "pos"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size"
    t.datetime "screenshot_updated_at"
  end

  add_index "agent_stats_uploads", ["agent_stat_id"], name: "index_agent_stats_uploads_on_agent_stat_id", using: :btree
  add_index "agent_stats_uploads", ["pos"], name: "index_agent_stats_uploads_on_pos", using: :btree

  create_table "user_oauths", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "refresh_token"
    t.string   "access_token"
    t.string   "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_oauths", ["uid"], name: "index_user_oauths_on_uid", unique: true, using: :btree
  add_index "user_oauths", ["user_id"], name: "index_user_oauths_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree

end
