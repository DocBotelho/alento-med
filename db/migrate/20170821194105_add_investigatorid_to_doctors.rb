class AddInvestigatoridToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :investigatorid, :string
  end
end
