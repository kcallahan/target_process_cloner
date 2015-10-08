class FixLookups < ActiveRecord::Migration
  def change
    remove_column :target_process_entities, :project_id, :integer

    add_column :target_process_entities, :target_process_project_id, :integer
    add_column :target_process_entities, :project_id, :integer
    add_column :target_process_entities, :epic_id, :integer
    add_column :target_process_entities, :feature_id, :integer
    add_column :target_process_entities, :user_story_id, :integer
  end
end
