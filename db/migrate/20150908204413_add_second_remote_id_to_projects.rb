class AddSecondRemoteIdToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :cloned_remote_id, :int
  end
end
