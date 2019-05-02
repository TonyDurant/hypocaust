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

ActiveRecord::Schema.define(version: 20161106184353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "attachments", force: true do |t|
    t.string   "name"
    t.string   "attachment"
    t.integer  "user_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree
  add_index "attachments", ["user_id"], name: "index_attachments_on_user_id", using: :btree

  create_table "blogs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "file"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id", "commentable_id"], name: "index_comments_on_user_id_and_commentable_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "construction_sites", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "customer_name"
    t.string   "email"
    t.string   "phone"
    t.float    "area"
    t.string   "avatar"
    t.integer  "customer_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "site_type"
    t.boolean  "vault",         default: false, null: false
    t.boolean  "public",        default: false, null: false
    t.boolean  "archive",       default: false
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "favorable_id"
    t.string   "favorable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["favorable_id"], name: "index_favorites_on_favorable_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "labours", force: true do |t|
    t.string   "name"
    t.string   "product_id"
    t.string   "system_id"
    t.string   "unit"
    t.float    "price"
    t.string   "description"
    t.integer  "service_id"
    t.integer  "user_id"
    t.integer  "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labours", ["product_id"], name: "index_labours_on_product_id", using: :btree
  add_index "labours", ["service_id"], name: "index_labours_on_service_id", using: :btree
  add_index "labours", ["system_id"], name: "index_labours_on_system_id", using: :btree
  add_index "labours", ["user_id"], name: "index_labours_on_user_id", using: :btree

  create_table "lead_times", force: true do |t|
    t.string   "title"
    t.string   "user_id"
    t.string   "construction_site_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lead_times", ["user_id", "construction_site_id"], name: "index_lead_times_on_user_id_and_construction_site_id", using: :btree

  create_table "link_thumbnails", force: true do |t|
    t.string   "name"
    t.string   "favicon"
    t.text     "desc"
    t.string   "image"
    t.integer  "comment_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "link_thumbnails", ["comment_id"], name: "index_link_thumbnails_on_comment_id", using: :btree

  create_table "metrics", force: true do |t|
    t.string   "name"
    t.float    "remain_hours"
    t.integer  "sprint_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "metrics", ["sprint_id"], name: "index_metrics_on_sprint_id", using: :btree

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "construction_site_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["construction_site_id"], name: "index_participations_on_construction_site_id", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_id", "searchable_type"], name: "index_pg_search_documents_on_searchable_id_and_searchable_type", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blog_id"
    t.string   "image_url"
    t.boolean  "draft",      default: false, null: false
    t.text     "short_desc"
    t.string   "url"
  end

  add_index "posts", ["blog_id"], name: "index_posts_on_blog_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "body"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "link"
    t.string   "service_type"
    t.string   "price"
    t.boolean  "draft",             default: false, null: false
  end

  create_table "sprints", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "construction_site_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sprints", ["construction_site_id"], name: "index_sprints_on_construction_site_id", using: :btree
  add_index "sprints", ["user_id"], name: "index_sprints_on_user_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "start_time"
    t.string   "state"
    t.integer  "construction_site_id"
    t.integer  "user_id"
    t.integer  "sprint_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "duration"
    t.string   "color",                default: "info"
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.datetime "end_time"
  end

  add_index "tasks", ["construction_site_id"], name: "index_tasks_on_construction_site_id", using: :btree
  add_index "tasks", ["sprint_id"], name: "index_tasks_on_sprint_id", using: :btree
  add_index "tasks", ["taskable_id"], name: "index_tasks_on_taskable_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "last_name"
    t.string   "avatar"
    t.string   "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
