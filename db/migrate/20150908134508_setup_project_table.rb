class SetupProjectTable < ActiveRecord::Migration
  def change
    add_column :projects, :name, :varchar

    add_index :projects, :id
  end
end
