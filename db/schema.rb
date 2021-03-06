# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151019132727) do

  create_table "epics", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "target_process_entity_id"
  end

  add_index "epics", ["target_process_entity_id"], name: "index_epics_on_target_process_entity_id"

  create_table "features", force: :cascade do |t|
    t.integer "epic_id"
    t.integer "target_process_entity_id"
  end

  add_index "features", ["epic_id"], name: "index_features_on_epic_id"
  add_index "features", ["target_process_entity_id"], name: "index_features_on_target_process_entity_id"

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "target_process_entity_id"
  end

  add_index "projects", ["id"], name: "index_projects_on_id"
  add_index "projects", ["target_process_entity_id"], name: "index_projects_on_target_process_entity_id"

  create_table "remote_projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "owner"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_process_entities", force: :cascade do |t|
    t.string   "type",                      null: false
    t.string   "name"
    t.text     "description"
    t.integer  "source_remote_id"
    t.float    "numeric_priority"
    t.integer  "owner"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "cloned_remote_id"
    t.string   "resource_type"
    t.integer  "target_process_project_id"
    t.integer  "project_id"
    t.integer  "epic_id"
    t.integer  "feature_id"
    t.integer  "user_story_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_stories", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "target_process_entity_id"
  end

  add_index "user_stories", ["target_process_entity_id"], name: "index_user_stories_on_target_process_entity_id"

end
