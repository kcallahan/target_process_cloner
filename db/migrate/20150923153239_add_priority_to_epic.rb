class AddPriorityToEpic < ActiveRecord::Migration
  def change
    add_column :epics, :numeric_priority, :int
  end
end
