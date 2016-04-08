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

ActiveRecord::Schema.define(version: 20160408135854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "kibokan_id",                   null: false
    t.string   "email"
    t.string   "password_digest", default: "", null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", using: :btree
  add_index "accounts", ["kibokan_id"], name: "index_accounts_on_kibokan_id", using: :btree

  create_table "delegates", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "group_id",                      null: false
    t.uuid     "account_id",                    null: false
    t.string   "permission", default: "normal", null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "delegates", ["account_id"], name: "index_delegates_on_account_id", using: :btree
  add_index "delegates", ["group_id"], name: "index_delegates_on_group_id", using: :btree

  create_table "divisions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "groups", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer "kibokan_id", null: false
  end

  add_index "groups", ["kibokan_id"], name: "index_groups_on_kibokan_id", using: :btree

  create_table "recovery_tokens", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "token",                      null: false
    t.uuid     "account_id",                 null: false
    t.boolean  "is_active",  default: false
    t.string   "type",       default: ""
    t.string   "substitute", default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "recovery_tokens", ["token"], name: "index_recovery_tokens_on_token", using: :btree
  add_index "recovery_tokens", ["type"], name: "index_recovery_tokens_on_type", using: :btree

  create_table "roles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.uuid     "division_id",                    null: false
    t.string   "permission",  default: "normal", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "roles", ["account_id"], name: "index_roles_on_account_id", using: :btree
  add_index "roles", ["division_id"], name: "index_roles_on_division_id", using: :btree

end
