class ChangeEntityNumericPriorityToFloat < ActiveRecord::Migration
  def change
    change_column :target_process_entities, :numeric_priority, :decimal
  end
end
