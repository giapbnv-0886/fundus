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

ActiveRecord::Schema.define(version: 2019_10_26_075529) do

  create_table "attendances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "user_id"], name: "index_attendances_on_event_id_and_user_id", unique: true
  end

  create_table "blogs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "hash_tag"
    t.text "content"
    t.text "photo", limit: 4294967295, collation: "utf8mb4_bin"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cause_id"
    t.string "slug"
    t.datetime "deleted_at"
    t.index ["category_id"], name: "index_blogs_on_category_id"
    t.index ["cause_id"], name: "index_blogs_on_cause_id"
    t.index ["deleted_at"], name: "index_blogs_on_deleted_at"
    t.index ["slug"], name: "index_blogs_on_slug"
    t.index ["user_id", "created_at"], name: "index_blogs_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "blogs_tags", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "blog_id"
    t.bigint "tag_id"
    t.index ["blog_id"], name: "index_blogs_tags_on_blog_id"
    t.index ["tag_id"], name: "index_blogs_tags_on_tag_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "causes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "detail"
    t.datetime "end_time"
    t.decimal "reached_money", precision: 10, default: "0"
    t.decimal "goal_money", precision: 10, default: "0"
    t.text "photos", limit: 4294967295, collation: "utf8mb4_bin"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "deleted_at"
    t.index ["category_id"], name: "index_causes_on_category_id"
    t.index ["deleted_at"], name: "index_causes_on_deleted_at"
    t.index ["slug"], name: "index_causes_on_slug"
    t.index ["user_id"], name: "index_causes_on_user_id"
  end

  create_table "causes_tags", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "cause_id"
    t.bigint "tag_id"
    t.index ["cause_id"], name: "index_causes_tags_on_cause_id"
    t.index ["tag_id"], name: "index_causes_tags_on_tag_id"
  end

  create_table "ckeditor_assets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.integer "parent_id"
    t.bigint "blog_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_comments_on_blog_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "delayed_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "donations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "amount", precision: 10, default: "0"
    t.bigint "user_id"
    t.bigint "cause_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "token"
    t.string "payer_id"
    t.datetime "purchased_at"
    t.datetime "deleted_at"
    t.index ["cause_id"], name: "index_donations_on_cause_id"
    t.index ["deleted_at"], name: "index_donations_on_deleted_at"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "place"
    t.integer "total_person"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "expiration_date"
    t.text "photos", limit: 4294967295, collation: "utf8mb4_bin"
    t.text "geocode", limit: 4294967295, collation: "utf8mb4_bin"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cause_id"
    t.string "slug"
    t.datetime "deleted_at"
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["cause_id"], name: "index_events_on_cause_id"
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["user_id", "created_at"], name: "index_events_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "events_tags", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "tag_id"
    t.index ["event_id"], name: "index_events_tags_on_event_id"
    t.index ["tag_id"], name: "index_events_tags_on_tag_id"
  end

  create_table "events_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "friendly_id_slugs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: { slug: 70, scope: 70 }
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: { slug: 140 }
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "role", default: "member"
    t.text "photo", limit: 4294967295, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "uid"
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "blogs", "categories"
  add_foreign_key "blogs", "causes"
  add_foreign_key "blogs", "users"
  add_foreign_key "blogs_tags", "blogs"
  add_foreign_key "blogs_tags", "tags"
  add_foreign_key "causes", "categories"
  add_foreign_key "causes", "users"
  add_foreign_key "causes_tags", "causes"
  add_foreign_key "causes_tags", "tags"
  add_foreign_key "comments", "blogs"
  add_foreign_key "comments", "users"
  add_foreign_key "donations", "causes"
  add_foreign_key "donations", "users"
  add_foreign_key "events", "categories"
  add_foreign_key "events", "causes"
  add_foreign_key "events", "users"
  add_foreign_key "events_tags", "events"
  add_foreign_key "events_tags", "tags"
end
