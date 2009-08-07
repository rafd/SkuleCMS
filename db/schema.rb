# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090807050633) do

  create_table "admin_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "club_id"
    t.boolean  "event"
    t.boolean  "updates"
    t.boolean  "member"
    t.boolean  "group"
    t.boolean  "file"
    t.boolean  "gallery"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
  end

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.boolean  "locked"
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tagline"
    t.string   "logo"
    t.string   "website"
    t.string   "contact"
    t.boolean  "affiliated"
    t.string   "official_name"
  end

  create_table "download_folders", :force => true do |t|
    t.integer  "club_id"
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downloads", :force => true do |t|
    t.integer  "download_folder_id"
    t.string   "name"
    t.string   "desc"
    t.string   "url"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "start"
    t.datetime "finish"
    t.string   "location"
    t.string   "description"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "groups", :force => true do |t|
    t.integer  "club_id"
    t.string   "name"
    t.text     "misc"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "bns_parent_id"
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "desc"
    t.integer  "album_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "large_posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.integer  "user_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "small_posts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.integer  "user_id"
    t.string   "origin"
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
    t.integer "user_id"
  end

  add_index "taggings", ["tag_id", "taggable_type"], :name => "index_taggings_on_tag_id_and_taggable_type"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"
  add_index "taggings", ["user_id", "tag_id", "taggable_type"], :name => "index_taggings_on_user_id_and_tag_id_and_taggable_type"
  add_index "taggings", ["user_id", "taggable_id", "taggable_type"], :name => "index_taggings_on_user_id_and_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0, :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"
  add_index "tags", ["taggings_count"], :name => "index_tags_on_taggings_count"

  create_table "updates", :force => true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
