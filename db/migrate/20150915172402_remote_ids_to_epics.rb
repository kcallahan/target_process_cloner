class RemoteIdsToEpics < ActiveRecord::Migration
  def change
    add_column :epics, :source_remote_id, :int
    add_column :epics, :cloned_remote_id, :int
  end
end
