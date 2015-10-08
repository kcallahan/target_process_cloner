class MassiveDbCleanup < ActiveRecord::Migration
  def change
    drop_table :projects
    drop_table :epics
    drop_table :features
    drop_table :user_stories
    drop_table :target_process_entities

    create_table "target_process_entities", force: :cascade do |t|
      t.string   "type",             null: false
      t.string   "name"
      t.text     "description"
      t.integer  "source_remote_id"
      t.float    "numeric_priority"
      t.integer  "owner"
      t.datetime "created_at",       null: false
      t.datetime "updated_at",       null: false
      t.integer  "cloned_remote_id"
      t.string   "resource_type"
    end    

    create_table "epics", force: :cascade do |t|
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
      t.integer  "target_process_entity_id"
      t.integer  "project_id"
    end

    add_index "epics", ["project_id"], name: "index_epics_on_project_id"
    add_index "epics", ["target_process_entity_id"], name: "index_epics_on_target_process_entity_id"

    create_table "features", force: :cascade do |t|
      t.integer  "project_id"
      t.integer  "epic_id"
      t.integer  "target_process_entity_id"
    end

    add_index "features", ["project_id"], name: "index_features_on_project_id"
    add_index "features", ["epic_id"], name: "index_features_on_epic_id"
    add_index "features", ["target_process_entity_id"], name: "index_features_on_target_process_entity_id"

    create_table "projects", force: :cascade do |t|
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
      t.integer  "target_process_entity_id"
    end

    add_index "projects", ["id"], name: "index_projects_on_id"
    add_index "projects", ["target_process_entity_id"], name: "index_projects_on_target_process_entity_id"

    create_table "user_stories", force: :cascade do |t|
      t.integer  "project_id"
      t.integer  "feature_id"
      t.datetime "created_at",       null: false
      t.datetime "updated_at",       null: false
      t.integer  "target_process_entity_id"
    end

    add_index "user_stories", ["project_id"], name: "index_user_stories_on_project_id"
    add_index "user_stories", ["feature_id"], name: "index_user_stories_on_feature_id"
    add_index "user_stories", ["target_process_entity_id"], name: "index_user_stories_on_target_process_entity_id"

    create_table "remote_projects", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string   "name"
      t.integer  "owner"
    end

  end
end
