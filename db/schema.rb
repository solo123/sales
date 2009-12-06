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

ActiveRecord::Schema.define(:version => 20091206145641) do

  create_table "brands", :force => true do |t|
    t.string   "short_name"
    t.string   "brand_name"
    t.integer  "status",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.string   "company"
    t.string   "name"
    t.string   "mobile"
    t.string   "phone"
    t.string   "email"
    t.string   "qq"
    t.string   "pin"
    t.integer  "level",      :default => 0
    t.integer  "status",     :default => 0
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobiles", :force => true do |t|
    t.integer  "brand_id",                                 :default => 0
    t.string   "name"
    t.string   "model"
    t.string   "part"
    t.string   "remark"
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "status",                                   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mquotations", :force => true do |t|
    t.integer  "mobile_id"
    t.decimal  "price",     :precision => 8, :scale => 2
    t.datetime "date"
  end

  create_table "quotations", :force => true do |t|
    t.integer  "supplier_id",                                    :default => 0
    t.integer  "brand_id",                                       :default => 0
    t.integer  "mobile_id",                                      :default => 0
    t.string   "brand_short_name"
    t.string   "model_short_name"
    t.decimal  "quotation_price",  :precision => 8, :scale => 2, :default => 0.0
    t.integer  "employee_id"
    t.datetime "quotation_date"
    t.integer  "status",                                         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remark"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "suppliers", :force => true do |t|
    t.string   "short_name"
    t.string   "company_name"
    t.string   "contact_phone"
    t.string   "email"
    t.string   "address"
    t.string   "remark"
    t.integer  "status",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact"
  end

  create_table "users", :force => true do |t|
    t.string   "login_name"
    t.string   "nick_name"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "status",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",         :default => 0
  end

end
