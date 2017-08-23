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

ActiveRecord::Schema.define(version: 20170823182137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "doctor_nct_id"
    t.string   "facility_id"
    t.string   "crm"
  end

  create_table "institutiondoctors", force: :cascade do |t|
    t.integer  "institution_id"
    t.integer  "doctor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["doctor_id"], name: "index_institutiondoctors_on_doctor_id", using: :btree
    t.index ["institution_id"], name: "index_institutiondoctors_on_institution_id", using: :btree
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "institution_nct_id"
    t.json     "institutioncontacts"
    t.string   "facility_id"
  end

  create_table "treatments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trial_id"
    t.integer  "institution_id"
    t.integer  "doctor_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["doctor_id"], name: "index_treatments_on_doctor_id", using: :btree
    t.index ["institution_id"], name: "index_treatments_on_institution_id", using: :btree
    t.index ["trial_id"], name: "index_treatments_on_trial_id", using: :btree
    t.index ["user_id"], name: "index_treatments_on_user_id", using: :btree
  end

  create_table "trialdoctors", force: :cascade do |t|
    t.integer  "trial_id"
    t.integer  "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_trialdoctors_on_doctor_id", using: :btree
    t.index ["trial_id"], name: "index_trialdoctors_on_trial_id", using: :btree
  end

  create_table "trialinstitutions", force: :cascade do |t|
    t.integer  "trial_id"
    t.integer  "institution_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["institution_id"], name: "index_trialinstitutions_on_institution_id", using: :btree
    t.index ["trial_id"], name: "index_trialinstitutions_on_trial_id", using: :btree
  end

  create_table "trials", force: :cascade do |t|
    t.string   "title"
    t.string   "condition",                    array: true
    t.text     "description"
    t.text     "eligibility"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "link"
    t.string   "trial_nct_id"
    t.json     "centralcontacts"
    t.string   "phase"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "location"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "phone"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "institutiondoctors", "doctors"
  add_foreign_key "institutiondoctors", "institutions"
  add_foreign_key "treatments", "doctors"
  add_foreign_key "treatments", "institutions"
  add_foreign_key "treatments", "trials"
  add_foreign_key "treatments", "users"
  add_foreign_key "trialdoctors", "doctors"
  add_foreign_key "trialdoctors", "trials"
  add_foreign_key "trialinstitutions", "institutions"
  add_foreign_key "trialinstitutions", "trials"
end
