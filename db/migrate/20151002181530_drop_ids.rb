class DropIds < ActiveRecord::Migration
  def change
    remove_column :epics, :project_id, :integer

    remove_column :features, :project_id, :integer
    remove_column :features, :epic, :integer

    remove_column :user_stories, :project_id, :integer
    remove_column :user_stories, :feature_id, :integer
  end
end
