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

ActiveRecord::Schema[7.2].define(version: 2024_11_19_113008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "criteria", force: :cascade do |t|
    t.string "title"
    t.bigint "idea_id"
    t.integer "criteria_type"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_criteria_on_idea_id"
  end

  create_table "criteria_mitigations", force: :cascade do |t|
    t.string "title"
    t.bigint "criteria_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criteria_id"], name: "index_criteria_mitigations_on_criteria_id"
  end

  create_table "criteria_ratings", force: :cascade do |t|
    t.float "rating"
    t.string "description"
    t.bigint "criteria_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criteria_id"], name: "index_criteria_ratings_on_criteria_id"
  end

  create_table "graphs", force: :cascade do |t|
    t.bigint "criteria_id", null: false
    t.integer "graph_type"
    t.json "graph_parameters"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criteria_id"], name: "index_graphs_on_criteria_id"
  end

  create_table "idea_conversations", force: :cascade do |t|
    t.json "conversation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "conversation_type", default: 0
    t.bigint "idea_conversationable_id"
    t.string "idea_conversationable_type"
  end

  create_table "idea_histories", force: :cascade do |t|
    t.bigint "idea_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_idea_histories_on_idea_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ellaboration"
    t.string "tid"
    t.string "market_potential"
  end

  add_foreign_key "criteria_mitigations", "criteria", column: "criteria_id"
  add_foreign_key "criteria_ratings", "criteria", column: "criteria_id"
  add_foreign_key "graphs", "criteria", column: "criteria_id"
  add_foreign_key "idea_histories", "ideas"
end
