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

ActiveRecord::Schema[8.1].define(version: 2026_08_19_194056) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "contact_methods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "effective_from", null: false
    t.date "effective_to"
    t.string "kind", null: false
    t.bigint "patient_id", null: false
    t.datetime "updated_at", null: false
    t.string "value", null: false
    t.index ["patient_id", "kind"], name: "index_current_contact_methods_on_patient_and_kind", unique: true, where: "(effective_to IS NULL)"
    t.index ["patient_id"], name: "index_contact_methods_on_patient_id"
  end

  create_table "intakes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date_of_birth", null: false
    t.string "email"
    t.string "full_name"
    t.string "insurance_provider"
    t.integer "patient_id", null: false
    t.string "phone_number"
    t.text "reason_for_visit"
    t.boolean "returning_patient"
    t.datetime "updated_at", null: false
    t.string "urgency"
    t.index ["patient_id"], name: "index_intakes_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date_of_birth", null: false
    t.string "email"
    t.string "full_name"
    t.string "phone_number"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "contact_methods", "patients"
  add_foreign_key "intakes", "patients"
end
