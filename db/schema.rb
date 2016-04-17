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

ActiveRecord::Schema.define(version: 20160412085908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "kibokan_id",                      null: false
    t.string   "email"
    t.string   "password_digest", default: "",    null: false
    t.boolean  "is_admin",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
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

  add_index "delegates", ["group_id", "account_id"], name: "index_delegates_on_group_id_and_account_id", unique: true, using: :btree

  create_table "divisions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "email_recovery_tokens", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "token",                      null: false
    t.uuid     "account_id",                 null: false
    t.boolean  "is_active",  default: false
    t.string   "email",                      null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "email_recovery_tokens", ["token"], name: "index_email_recovery_tokens_on_token", using: :btree

  create_table "group_topics", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "group_id",     null: false
    t.uuid     "topic_id",     null: false
    t.datetime "last_read_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "group_topics", ["group_id", "topic_id"], name: "index_group_topics_on_group_id_and_topic_id", unique: true, using: :btree

  create_table "groups", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer "kibokan_id", null: false
  end

  add_index "groups", ["kibokan_id"], name: "index_groups_on_kibokan_id", using: :btree

  create_table "invitation_tokens", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "token",                       null: false
    t.uuid     "division_id",                 null: false
    t.boolean  "is_active",   default: false
    t.string   "email",                       null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "invitation_tokens", ["token"], name: "index_invitation_tokens_on_token", using: :btree

  create_table "password_recovery_tokens", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "token",                      null: false
    t.uuid     "account_id",                 null: false
    t.boolean  "is_active",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "password_recovery_tokens", ["token"], name: "index_password_recovery_tokens_on_token", using: :btree

  create_table "posts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "body",           default: ""
    t.uuid     "author_id",                      null: false
    t.uuid     "division_id",                    null: false
    t.uuid     "group_topic_id",                 null: false
    t.boolean  "is_draft",       default: false
    t.datetime "sended_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "posts", ["group_topic_id"], name: "index_posts_on_group_topic_id", using: :btree
  add_index "posts", ["is_draft"], name: "index_posts_on_is_draft", using: :btree

  create_table "roles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "account_id",                     null: false
    t.uuid     "division_id",                    null: false
    t.string   "permission",  default: "normal", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "roles", ["account_id", "division_id"], name: "index_roles_on_account_id_and_division_id", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "topics", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title",                         null: false
    t.string   "description",   default: ""
    t.uuid     "account_id",                    null: false
    t.uuid     "proposer_id",                   null: false
    t.string   "proposer_type",                 null: false
    t.boolean  "is_draft",      default: false
    t.datetime "sended_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "topics", ["proposer_id", "proposer_type"], name: "index_topics_on_proposer_id_and_proposer_type", using: :btree

end
