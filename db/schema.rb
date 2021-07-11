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

ActiveRecord::Schema.define(version: 2021_07_11_211623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctor_insurances", force: :cascade do |t|
    t.bigint "insurance_id"
    t.bigint "doctor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_doctor_insurances_on_doctor_id"
    t.index ["insurance_id"], name: "index_doctor_insurances_on_insurance_id"
  end

  create_table "doctor_specialties", force: :cascade do |t|
    t.bigint "specialty_id"
    t.bigint "doctor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_doctor_specialties_on_doctor_id"
    t.index ["specialty_id"], name: "index_doctor_specialties_on_specialty_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "unit"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.boolean "vetted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "insurances", force: :cascade do |t|
    t.string "company"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mental_health_professionals", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "unit"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "cost"
    t.boolean "vetted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mhp_insurances", force: :cascade do |t|
    t.bigint "mental_health_professional_id"
    t.bigint "insurance_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["insurance_id"], name: "index_mhp_insurances_on_insurance_id"
    t.index ["mental_health_professional_id"], name: "index_mhp_insurances_on_mental_health_professional_id"
  end

  create_table "mhp_specialties", force: :cascade do |t|
    t.bigint "mental_health_professional_id"
    t.bigint "specialty_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mental_health_professional_id"], name: "index_mhp_specialties_on_mental_health_professional_id"
    t.index ["specialty_id"], name: "index_mhp_specialties_on_specialty_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
