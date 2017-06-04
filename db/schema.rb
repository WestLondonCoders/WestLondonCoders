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

ActiveRecord::Schema.define(version: 20170604101532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type", using: :btree

  create_table "comment_replies", force: :cascade do |t|
    t.text     "body",                      null: false
    t.integer  "comment_id",                null: false
    t.integer  "author_id",                 null: false
    t.boolean  "public",     default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "author_id"
    t.boolean  "public",           default: true
  end

  create_table "event_rsvps", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "event_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_rsvps", ["user_id", "event_id"], name: "index_event_rsvps_on_user_id_and_event_id", unique: true, using: :btree
  add_index "event_rsvps", ["user_id"], name: "index_event_rsvps_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.string   "slug"
    t.datetime "date",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "sponsor_id"
    t.datetime "finish_date"
  end

  create_table "hackroom_languages", force: :cascade do |t|
    t.integer  "hackroom_id", null: false
    t.integer  "language_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "hackroom_owners", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "hackroom_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "hackroom_owners", ["hackroom_id", "user_id"], name: "index_hackroom_owners_on_hackroom_id_and_user_id", unique: true, using: :btree

  create_table "hackroom_primaries", force: :cascade do |t|
    t.integer  "hackroom_id", null: false
    t.integer  "language_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "hackrooms", force: :cascade do |t|
    t.string   "name",                         null: false
    t.text     "mission"
    t.string   "slack"
    t.string   "project_url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "slug"
    t.integer  "popularity_score", default: 0
  end

  add_index "hackrooms", ["slug"], name: "index_hackrooms_on_slug", unique: true, using: :btree

  create_table "interests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "description"
    t.string   "colour",           default: "#000000", null: false
    t.string   "slug",             default: ""
    t.integer  "popularity_score", default: 0
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.string   "action"
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "notifications", ["notifiable_id"], name: "index_notifications_on_notifiable_id", using: :btree
  add_index "notifications", ["notified_by_id"], name: "index_notifications_on_notified_by_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "organiser_interests", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "notified_at"
  end

  add_index "organiser_interests", ["user_id"], name: "index_organiser_interests_on_user_id", unique: true, using: :btree

  create_table "post_attachments", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_tags", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.string   "slug"
    t.boolean  "featured",      default: false
    t.string   "description",   default: "I wrote a post on West London Coders"
    t.string   "twitter_image", default: "http://westlondoncoders.com/assets/general/twitter-81cac2affbb3e01cae4dce459fbf82a25f465cc53da98bf9d742afa3320ffe71.jpg"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "sponsor_languages", force: :cascade do |t|
    t.integer  "sponsor_id",  null: false
    t.integer  "language_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sponsors", force: :cascade do |t|
    t.string   "name",                                null: false
    t.text     "description"
    t.string   "logo"
    t.text     "address"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "link"
    t.string   "description_heading"
    t.boolean  "listed",              default: false, null: false
    t.string   "slug",                default: ""
  end

  create_table "sponsorship_admins", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "sponsor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  add_index "tags", ["creator_id"], name: "index_tags_on_creator_id", using: :btree

  create_table "user_follows", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_hackrooms", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "hackroom_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_hackrooms", ["user_id", "hackroom_id"], name: "index_user_hackrooms_on_user_id_and_hackroom_id", unique: true, using: :btree

  create_table "user_interests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tag_id"
  end

  add_index "user_interests", ["tag_id"], name: "index_user_interests_on_tag_id", using: :btree

  create_table "user_languages", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "language_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_primaries", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "language_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.text     "bio"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "github"
    t.string   "instagram"
    t.string   "website_url"
    t.string   "linkedin"
    t.string   "tagline"
    t.string   "slug"
    t.integer  "permission"
    t.string   "logo"
    t.string   "logo_link"
    t.string   "username"
    t.boolean  "listed",                 default: true
    t.string   "first_name",             default: "",   null: false
    t.string   "last_name",              default: "",   null: false
    t.integer  "user_follows_count",     default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  add_foreign_key "event_rsvps", "events", on_delete: :cascade
  add_foreign_key "event_rsvps", "users", on_delete: :cascade
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
end
