class AddPhaseToTrials < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :phase, :string
  end
end
