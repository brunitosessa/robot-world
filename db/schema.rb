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

ActiveRecord::Schema.define(version: 2021_06_22_132501) do

  create_table "cars", charset: "utf8mb4", force: :cascade do |t|
    t.integer "year"
    t.boolean "is_painted", default: false, null: false
    t.string "status", default: "new", null: false
    t.string "location", default: "factory", null: false
    t.float "price"
    t.float "cost_price"
    t.bigint "model_id", null: false
    t.bigint "computer_id"
    t.index ["computer_id"], name: "index_cars_on_computer_id"
    t.index ["model_id"], name: "index_cars_on_model_id"
  end

  create_table "computers", charset: "utf8mb4", force: :cascade do |t|
  end

  create_table "events", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "car_id"
    t.bigint "order_id"
    t.bigint "model_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_events_on_car_id"
    t.index ["model_id"], name: "index_events_on_model_id"
    t.index ["order_id"], name: "index_events_on_order_id"
  end

  create_table "models", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
  end

  create_table "orders", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_orders_on_car_id"
  end

  create_table "part_types", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "assembly_line"
  end

  create_table "parts", charset: "utf8mb4", force: :cascade do |t|
    t.boolean "defect"
    t.bigint "car_id"
    t.bigint "part_type_id", null: false
    t.index ["car_id"], name: "index_parts_on_car_id"
    t.index ["part_type_id", "car_id"], name: "index_parts_on_part_type_id_and_car_id", unique: true
    t.index ["part_type_id"], name: "index_parts_on_part_type_id"
  end

  add_foreign_key "cars", "computers", on_delete: :cascade
  add_foreign_key "cars", "models"
  add_foreign_key "events", "cars", on_delete: :cascade
  add_foreign_key "events", "models", on_delete: :cascade
  add_foreign_key "events", "orders", on_delete: :cascade
  add_foreign_key "orders", "cars", on_delete: :cascade
  add_foreign_key "parts", "cars", on_delete: :cascade
  add_foreign_key "parts", "part_types"
end
