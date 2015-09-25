class AddResourceTypeToEntity < ActiveRecord::Migration
  def change
    add_column :target_process_entities, :resource_type, :string
  end
end
