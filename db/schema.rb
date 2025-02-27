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

ActiveRecord::Schema.define(version: 2024_05_03_164721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "repost_id"
    t.bigint "quote_id"
    t.bigint "original_post_id"
    t.string "quote_content"
    t.index ["original_post_id"], name: "index_posts_on_original_post_id"
    t.index ["quote_id"], name: "index_posts_on_quote_id"
    t.index ["repost_id"], name: "index_posts_on_repost_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "posts", "posts", column: "original_post_id"
  add_foreign_key "posts", "posts", column: "quote_id"
  add_foreign_key "posts", "posts", column: "repost_id"
  add_foreign_key "posts", "users"
end
