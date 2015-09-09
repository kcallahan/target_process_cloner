class ChangeProjectRemoteIdToSourceRemoteId < ActiveRecord::Migration
  def change
  	rename_column :projects, :remote_id, :source_remote_id
  end
end
