class AddNctidToTrials < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :trial_nct_id, :string
  end
end
