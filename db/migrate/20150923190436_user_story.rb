class UserStory < ActiveRecord::Migration
  def change
    create_table :user_stories do |t|
      t.string :name
      t.integer :owner
      t.integer :project_id
      t.integer :feature_id
      t.integer :numeric_priority
      t.integer :cloned_remote_id
      t.integer :source_remote_id

      t.timestamps null: false
    end
  end
end
