class AddCentralcontactsToTrials < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :centralcontacts, :json
  end
end
