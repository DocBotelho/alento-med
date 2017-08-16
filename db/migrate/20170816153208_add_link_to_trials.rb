class AddLinkToTrials < ActiveRecord::Migration[5.0]
  def change
    add_column :trials, :link, :string
  end
end
