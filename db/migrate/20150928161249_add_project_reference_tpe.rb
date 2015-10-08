class AddProjectReferenceTpe < ActiveRecord::Migration
  def change
    remove_column :epics, :project_id, :integer

    add_reference :projects, :target_process_entity, index: true
    add_foreign_key :projects, :target_process_entities

    add_reference :epics, :target_process_entity, index: true
    add_foreign_key :epics, :target_process_entities

    add_reference :epics, :project, index: true
    add_foreign_key :epics, :projects
  end
end
