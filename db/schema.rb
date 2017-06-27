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

ActiveRecord::Schema.define(version: 20170627201054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.boolean "public", default: true
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "author_id", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "published_at"
    t.string "colour", default: "#000000", null: false
    t.index ["author_id"], name: "index_courses_on_author_id"
  end

  create_table "hackroom_languages", id: :serial, force: :cascade do |t|
    t.integer "hackroom_id", null: false
    t.integer "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hackroom_owners", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "hackroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hackroom_id", "user_id"], name: "index_hackroom_owners_on_hackroom_id_and_user_id", unique: true
  end

  create_table "hackroom_primaries", id: :serial, force: :cascade do |t|
    t.integer "hackroom_id", null: false
    t.integer "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hackrooms", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "mission"
    t.string "slack"
    t.string "project_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "popularity_score", default: 0
    t.integer "author_id"
    t.index ["slug"], name: "index_hackrooms_on_slug", unique: true
  end

  create_table "interests", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "language_courses", force: :cascade do |t|
    t.bigint "language_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_language_courses_on_course_id"
    t.index ["language_id"], name: "index_language_courses_on_language_id"
  end

  create_table "languages", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "colour", default: "#000000", null: false
    t.string "slug", default: ""
    t.integer "popularity_score", default: 0
    t.integer "author_id"
    t.string "image"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "likeable_id"
    t.string "likeable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_id"], name: "index_likes_on_likeable_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "meetup_rsvps", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "meetup_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "meetup_id"], name: "index_meetup_rsvps_on_user_id_and_meetup_id", unique: true
    t.index ["user_id"], name: "index_meetup_rsvps_on_user_id"
  end

  create_table "meetups", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "slug"
    t.datetime "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sponsor_id"
    t.datetime "finish_date"
    t.integer "author_id"
    t.boolean "announced", default: false
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "notified_by_id"
    t.string "action"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_id"], name: "index_notifications_on_notifiable_id"
    t.index ["notified_by_id"], name: "index_notifications_on_notified_by_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "post_tags", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by_id"
    t.string "slug"
    t.boolean "featured", default: false
    t.string "description", default: "I wrote a post on West London Coders"
    t.string "twitter_image", default: "http://westlondoncoders.com/assets/general/twitter-81cac2affbb3e01cae4dce459fbf82a25f465cc53da98bf9d742afa3320ffe71.jpg"
    t.boolean "announced", default: false
    t.index ["slug"], name: "index_posts_on_slug"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "sponsor_languages", id: :serial, force: :cascade do |t|
    t.integer "sponsor_id", null: false
    t.integer "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "logo"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.string "description_heading"
    t.boolean "listed", default: false, null: false
    t.string "slug", default: ""
  end

  create_table "sponsorship_admins", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "sponsor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "step_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "step_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_step_completions_on_step_id"
    t.index ["user_id"], name: "index_step_completions_on_user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "title", null: false
    t.integer "position", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.string "slug"
    t.index ["course_id"], name: "index_steps_on_course_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "creator_id"
    t.index ["creator_id"], name: "index_tags_on_creator_id"
  end

  create_table "user_follows", id: :serial, force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_hackrooms", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "hackroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "hackroom_id"], name: "index_user_hackrooms_on_user_id_and_hackroom_id", unique: true
  end

  create_table "user_interests", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "interest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "tag_id"
    t.index ["tag_id"], name: "index_user_interests_on_tag_id"
  end

  create_table "user_languages", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_primaries", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "image"
    t.text "bio"
    t.string "twitter"
    t.string "facebook"
    t.string "github"
    t.string "instagram"
    t.string "website_url"
    t.string "linkedin"
    t.string "tagline"
    t.string "slug"
    t.integer "permission"
    t.string "logo"
    t.string "logo_link"
    t.string "username"
    t.boolean "listed", default: true
    t.string "first_name", default: "", null: false
    t.string "last_name", default: ""
    t.integer "user_follows_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug"
  end

  add_foreign_key "likes", "users"
  add_foreign_key "meetup_rsvps", "meetups", on_delete: :cascade
  add_foreign_key "meetup_rsvps", "users", on_delete: :cascade
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "notified_by_id"
end
