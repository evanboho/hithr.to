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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120322033253) do

  create_table "abouts", :force => true do |t|
    t.string   "genre"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "nickname"
    t.string   "photo_url"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "details", :force => true do |t|
    t.integer  "seats_available"
    t.integer  "cost"
    t.string   "radio"
    t.integer  "smoking"
    t.integer  "bikes"
    t.text     "message"
    t.string   "confirmed_riders"
    t.integer  "ride_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "details", ["ride_id"], :name => "index_details_on_ride_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ride_id"
    t.boolean  "read"
    t.string   "sujet"
  end

  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "profiles", :force => true do |t|
    t.date     "birthday"
    t.string   "gender"
    t.string   "hometown"
    t.text     "about"
    t.integer  "user_id"
    t.integer  "cred"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "references", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.text     "content"
    t.integer  "positive"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "references", ["sender_id"], :name => "index_references_on_sender_id"
  add_index "references", ["user_id"], :name => "index_references_on_user_id"

  create_table "rides", :force => true do |t|
    t.string   "start_city"
    t.string   "start_state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "end_city"
    t.string   "end_state"
    t.float    "end_lat"
    t.float    "end_long"
    t.float    "bearing"
    t.float    "trip_distance"
    t.datetime "go_time"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rides", ["user_id"], :name => "index_rides_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "lastname"
    t.string   "firstname"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
