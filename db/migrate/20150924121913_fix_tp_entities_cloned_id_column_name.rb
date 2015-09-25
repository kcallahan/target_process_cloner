class FixTpEntitiesClonedIdColumnName < ActiveRecord::Migration
  def change
    remove_column :target_process_entities, :source_cloned_id
    add_column :target_process_entities, :cloned_remote_id, :int
  end
end
