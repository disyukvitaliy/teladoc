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

ActiveRecord::Schema.define(version: 2023_09_13_141342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "specialist_id", null: false
    t.bigint "patient_id"
    t.datetime "time", null: false
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["specialist_id"], name: "index_appointments_on_specialist_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "specialist_id", null: false
    t.integer "week_day", null: false
    t.integer "start_offset", null: false
    t.integer "appointment_duration", null: false
    t.integer "appointments_count", null: false
    t.index ["specialist_id", "week_day"], name: "index_schedules_on_specialist_id_and_week_day", unique: true
  end

  create_table "specialists", force: :cascade do |t|
    t.string "name", null: false
  end

end
