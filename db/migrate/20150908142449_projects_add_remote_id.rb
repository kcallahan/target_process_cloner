class ProjectsAddRemoteId < ActiveRecord::Migration
  def change
  	add_column :projects, :remote_id, :integer
  end
end
