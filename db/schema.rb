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

ActiveRecord::Schema.define(version: 20170313210215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "photos", force: :cascade do |t|
    t.text     "image_data"
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       :null=>false
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             :null=>false
    t.string   "last_name",              :null=>false
    t.string   "email",                  :default=>"", :null=>false, :index=>{:name=>"index_users_on_email", :unique=>true, :using=>:btree}
    t.string   "encrypted_password",     :default=>"", :null=>false
    t.string   "reset_password_token",   :index=>{:name=>"index_users_on_reset_password_token", :unique=>true, :using=>:btree}
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default=>0, :null=>false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",             :null=>false
    t.datetime "updated_at",             :null=>false
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer  "user_id",    :foreign_key=>{:references=>"users", :name=>"fk_roles_users_user_id", :on_update=>:no_action, :on_delete=>:no_action}, :index=>{:name=>"fk__roles_users_user_id", :using=>:btree}
    t.integer  "role_id",    :foreign_key=>{:references=>"roles", :name=>"fk_roles_users_role_id", :on_update=>:no_action, :on_delete=>:no_action}, :index=>{:name=>"fk__roles_users_role_id", :using=>:btree}
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",          :index=>{:name=>"index_states_on_name", :unique=>true, :using=>:btree}
    t.integer  "from_state_id", :foreign_key=>{:references=>"states", :name=>"fk_states_from_state_id", :on_update=>:no_action, :on_delete=>:no_action}, :index=>{:name=>"fk__states_from_state_id", :using=>:btree}
    t.datetime "created_at",    :null=>false
    t.datetime "updated_at",    :null=>false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id",   :foreign_key=>{:references=>"states", :name=>"fk_vehicles_state_id", :on_update=>:no_action, :on_delete=>:no_action}, :index=>{:name=>"fk__vehicles_state_id", :using=>:btree}
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

end
