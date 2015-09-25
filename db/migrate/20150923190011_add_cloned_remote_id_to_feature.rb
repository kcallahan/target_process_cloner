class AddClonedRemoteIdToFeature < ActiveRecord::Migration
  def change
    add_column :features, :cloned_remote_id, :int
  end
end
