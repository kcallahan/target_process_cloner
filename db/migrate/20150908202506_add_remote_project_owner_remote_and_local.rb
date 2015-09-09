class AddRemoteProjectOwnerRemoteAndLocal < ActiveRecord::Migration
  def change
  	add_column :projects, :owner, :int
  end
end
