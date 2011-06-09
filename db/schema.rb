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

ActiveRecord::Schema.define(:version => 20110609154934) do

  create_table "children", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "dietary_restrictions"
    t.string   "allergies"
    t.string   "medications"
    t.string   "notes"
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "children_requests", :id => false, :force => true do |t|
    t.integer  "child_id"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hidden_requests", :force => true do |t|
    t.integer  "request_id"
    t.integer  "household_hidden_id"
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "belongs_to_household_id"
  end

  create_table "households", :force => true do |t|
    t.string   "name"
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "num_children",       :default => 0, :null => false
  end

  create_table "neighbors", :force => true do |t|
    t.integer  "household_id"
    t.integer  "neighbor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "household_confirmed", :default => "f"
    t.string   "neighbor_confirmed",  :default => "f"
  end

  create_table "pending_requests", :force => true do |t|
    t.integer  "request_id"
    t.integer  "caregiver_requestor_id"
    t.string   "pending"
    t.integer  "caregiver_commit_id"
    t.string   "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "belongs_to_household_id"
  end

  create_table "requests", :force => true do |t|
    t.datetime "from_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id"
    t.datetime "to_date"
    t.string   "title"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "description"
    t.integer  "users_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "phone"
    t.integer  "role_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id"
  end

end
