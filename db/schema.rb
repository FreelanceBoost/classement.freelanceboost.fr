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

ActiveRecord::Schema.define(version: 20150618120806) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "dribblers", force: :cascade do |t|
    t.string   "bio",             limit: 512
    t.string   "name",            limit: 256
    t.integer  "followers_count"
    t.string   "location",        limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
    t.integer  "followers"
    t.string   "picture",         limit: 256
    t.string   "username",        limit: 256
  end

  create_table "githubers", force: :cascade do |t|
    t.string   "bio",               limit: 512
    t.string   "name",              limit: 256
    t.integer  "followers_count"
    t.string   "location",          limit: 256
    t.boolean  "published"
    t.string   "company",           limit: 256
    t.integer  "rank"
    t.string   "avatar_url",        limit: 256
    t.string   "blog",              limit: 256
    t.string   "github_login",      limit: 64
    t.string   "github_type",       limit: 64
    t.string   "email",             limit: 256
    t.integer  "following_count"
    t.integer  "public_repo"
    t.integer  "public_gist"
    t.boolean  "hireable"
    t.integer  "github_id"
    t.datetime "github_updated_at"
    t.datetime "github_created_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "githuburl",         limit: 256
  end

  create_table "rockstars", force: :cascade do |t|
    t.string   "pseudo",         limit: 255
    t.text     "desc"
    t.text     "url_img"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",           limit: 255
    t.string   "location",       limit: 255
    t.integer  "follower_count"
  end

end
