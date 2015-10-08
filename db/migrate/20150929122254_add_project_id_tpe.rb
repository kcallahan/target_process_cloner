class AddProjectIdTpe < ActiveRecord::Migration
  def change
    add_column :target_process_entities, :project_id, :integer
  end
end
