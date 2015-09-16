class CreateEpics < ActiveRecord::Migration
  def change
    create_table :epics do |t|
      t.string :name
      t.integer :owner
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
