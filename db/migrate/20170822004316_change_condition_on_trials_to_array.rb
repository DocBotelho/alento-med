class ChangeConditionOnTrialsToArray < ActiveRecord::Migration[5.0]
  def change
    change_column :trials, :condition, "varchar[] USING (string_to_array(condition, ','))"
  end
end
