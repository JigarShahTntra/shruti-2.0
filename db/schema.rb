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

ActiveRecord::Schema[7.2].define(version: 2025_01_27_152821) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "conversationable_type", null: false
    t.bigint "conversationable_id", null: false
    t.jsonb "body"
    t.index ["conversationable_type", "conversationable_id"], name: "index_conversations_on_conversationable"
  end

  create_table "idea_parameter_details", force: :cascade do |t|
    t.bigint "stage_gate_parameter_id", null: false
    t.bigint "idea_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "idea_stage_gate_id", null: false
    t.index ["idea_id"], name: "index_idea_parameter_details_on_idea_id"
    t.index ["idea_stage_gate_id"], name: "index_idea_parameter_details_on_idea_stage_gate_id"
    t.index ["stage_gate_parameter_id"], name: "index_idea_parameter_details_on_stage_gate_parameter_id"
  end

  create_table "idea_parameter_graphs", force: :cascade do |t|
    t.bigint "stage_gate_parameter_graph_id", null: false
    t.jsonb "body"
    t.bigint "idea_parameter_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_parameter_detail_id"], name: "index_idea_parameter_graphs_on_idea_parameter_detail_id"
    t.index ["stage_gate_parameter_graph_id"], name: "index_idea_parameter_graphs_on_stage_gate_parameter_graph_id"
  end

  create_table "idea_parameter_recommendation_details", force: :cascade do |t|
    t.bigint "idea_parameter_detail_id", null: false
    t.bigint "parameter_recommendation_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_parameter_detail_id"], name: "idx_on_idea_parameter_detail_id_4290c0d1fd"
    t.index ["parameter_recommendation_id"], name: "idx_on_parameter_recommendation_id_ed89907239"
  end

  create_table "idea_recommendation_formats", force: :cascade do |t|
    t.jsonb "body"
    t.bigint "idea_parameter_recommendation_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_parameter_recommendation_detail_id"], name: "idx_on_idea_parameter_recommendation_detail_id_36737e5a99"
  end

  create_table "idea_stage_gates", force: :cascade do |t|
    t.bigint "idea_id", null: false
    t.bigint "stage_gate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_idea_stage_gates_on_idea_id"
    t.index ["stage_gate_id"], name: "index_idea_stage_gates_on_stage_gate_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "tid"
    t.string "elaboration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "market_potential"
    t.string "intellectual_property_potential"
    t.string "technology_requirements"
    t.string "compliance_aspect"
    t.string "business_model"
    t.integer "status"
  end

  create_table "parameter_recommendations", force: :cascade do |t|
    t.bigint "stage_gate_parameter_id", null: false
    t.string "name"
    t.string "prompt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.jsonb "response_format"
    t.index ["stage_gate_parameter_id"], name: "index_parameter_recommendations_on_stage_gate_parameter_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "value"
    t.string "rateable_type", null: false
    t.bigint "rateable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "recommendable_type", null: false
    t.bigint "recommendable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recommendable_type", "recommendable_id"], name: "index_recommendations_on_recommendable"
  end

  create_table "stage_gate_parameter_graphs", force: :cascade do |t|
    t.bigint "stage_gate_parameter_id", null: false
    t.string "prompt"
    t.jsonb "response_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stage_gate_parameter_id"], name: "index_stage_gate_parameter_graphs_on_stage_gate_parameter_id"
  end

  create_table "stage_gate_parameters", force: :cascade do |t|
    t.bigint "stage_gate_id", null: false
    t.string "name"
    t.string "prompt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["stage_gate_id"], name: "index_stage_gate_parameters_on_stage_gate_id"
  end

  create_table "stage_gates", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "use_cases", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "pain_areas", array: true
    t.bigint "idea_id", null: false
    t.string "practice_component", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_use_cases_on_idea_id"
  end

  add_foreign_key "idea_parameter_details", "idea_stage_gates"
  add_foreign_key "idea_parameter_details", "ideas"
  add_foreign_key "idea_parameter_details", "stage_gate_parameters"
  add_foreign_key "idea_parameter_graphs", "idea_parameter_details"
  add_foreign_key "idea_parameter_graphs", "stage_gate_parameter_graphs"
  add_foreign_key "idea_parameter_recommendation_details", "idea_parameter_details"
  add_foreign_key "idea_parameter_recommendation_details", "parameter_recommendations"
  add_foreign_key "idea_recommendation_formats", "idea_parameter_recommendation_details"
  add_foreign_key "idea_stage_gates", "ideas"
  add_foreign_key "idea_stage_gates", "stage_gates"
  add_foreign_key "parameter_recommendations", "stage_gate_parameters"
  add_foreign_key "stage_gate_parameter_graphs", "stage_gate_parameters"
  add_foreign_key "stage_gate_parameters", "stage_gates"
  add_foreign_key "use_cases", "ideas"
end
