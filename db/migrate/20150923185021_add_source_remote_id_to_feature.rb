class AddSourceRemoteIdToFeature < ActiveRecord::Migration
  def change
    add_column :features, :source_remote_id, :int
  end
end
