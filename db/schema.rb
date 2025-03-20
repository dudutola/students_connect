# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_19_125805) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "overview"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "favourited_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favourited_user_id"], name: "index_favourites_on_favourited_user_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "lecture_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lecture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_lecture_users_on_lecture_id"
    t.index ["user_id"], name: "index_lecture_users_on_user_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.string "title"
    t.string "group_name"
    t.string "resource_url"
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_lectures_on_chapter_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status"
    t.bigint "requester_id", null: false
    t.bigint "receiver_id", null: false
    t.bigint "lecture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_meetings_on_lecture_id"
    t.index ["receiver_id"], name: "index_meetings_on_receiver_id"
    t.index ["requester_id"], name: "index_meetings_on_requester_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meeting_id", null: false
    t.string "message"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_notifications_on_meeting_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "user_id", null: false
    t.integer "reviewer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "solid_cable_messages", force: :cascade do |t|
    t.text "channel"
    t.text "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel"], name: "index_solid_cable_messages_on_channel"
    t.index ["created_at"], name: "index_solid_cable_messages_on_created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bio"
    t.string "education"
    t.string "username"
    t.string "name"
    t.string "avatar_url"
    t.string "location"
    t.string "uid"
    t.string "provider"
    t.text "description"
    t.text "skills"
    t.string "github_url"
    t.string "linkedin_url"
    t.string "slack_url"
    t.string "timezone"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favourites", "users"
  add_foreign_key "favourites", "users", column: "favourited_user_id"
  add_foreign_key "lecture_users", "lectures"
  add_foreign_key "lecture_users", "users"
  add_foreign_key "lectures", "chapters"
  add_foreign_key "meetings", "lectures"
  add_foreign_key "meetings", "users", column: "receiver_id"
  add_foreign_key "meetings", "users", column: "requester_id"
  add_foreign_key "notifications", "meetings"
  add_foreign_key "notifications", "users"
  add_foreign_key "reviews", "users"
end
