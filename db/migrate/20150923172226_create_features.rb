class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.integer :owner
      t.integer :project_id
      t.integer :epic_id
      t.integer :numeric_priority

      t.timestamps null: false
    end
  end
end
