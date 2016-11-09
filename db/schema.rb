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

ActiveRecord::Schema.define(version: 20161108202602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "vin",                limit: 17
    t.integer  "mileage"
    t.integer  "year"
    t.string   "make"
    t.string   "model"
    t.string   "color"
    t.string   "transmission"
    t.string   "engine"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 64
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "title",       limit: 64
    t.string   "description"
    t.boolean  "open",                   default: false
    t.integer  "urgency",                default: 1
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "maintenances", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "title",          limit: 64
    t.string   "description"
    t.integer  "mileage"
    t.integer  "shop_id"
    t.date     "date_completed"
    t.integer  "rating"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "car_id"
    t.integer  "issue_id"
    t.string   "report_type", limit: 11
    t.string   "token"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "repairs", force: :cascade do |t|
    t.integer  "repairable_id"
    t.string   "repairable_type"
    t.string   "title",           limit: 64
    t.string   "description"
    t.integer  "mileage"
    t.integer  "shop_id"
    t.date     "date_completed"
    t.integer  "rating"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["repairable_type", "repairable_id"], name: "index_repairs_on_repairable_type_and_repairable_id", using: :btree
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name",        limit: 64
    t.integer  "mechanic_id"
    t.string   "address",     limit: 128
    t.string   "city",        limit: 64
    t.string   "state"
    t.string   "zip_code",    limit: 5
    t.string   "phone",                   default: ""
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "title",         limit: 64
    t.string   "description"
    t.boolean  "public_access",            default: false
    t.integer  "user_id"
    t.integer  "car_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 64
    t.string   "last_name",              limit: 64
    t.string   "phone",                             default: ""
    t.boolean  "mech_status",                       default: false
    t.string   "zip_code",                          default: ""
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",                   default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

end
