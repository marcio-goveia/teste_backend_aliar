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

ActiveRecord::Schema.define(version: 2021_07_21_012356) do

  create_table "exams", force: :cascade do |t|
    t.string "name", null: false
    t.integer "kind", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exams_laboratories", id: false, force: :cascade do |t|
    t.integer "laboratory_id", null: false
    t.integer "exam_id", null: false
    t.index ["exam_id", nil], name: "index_exams_laboratories_on_exam_id_and_laborotory_id", unique: true
    t.index [nil, "exam_id"], name: "index_exams_laboratories_on_laborotory_id_and_exam_id", unique: true
  end

  create_table "laboratories", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
