class AddSponsorToTrials < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :sponsor, :string
  end
end
