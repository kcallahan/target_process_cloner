class CreateTargetProcessEntities < ActiveRecord::Migration
  def change
    create_table :target_process_entities do |t|
      t.string  :type, null:false
      t.string  :name
      t.text    :description
      t.integer :source_remote_id
      t.integer :source_cloned_id
      t.integer :numeric_priority
      t.integer :owner

      t.timestamps null: false
    end
  end
end
