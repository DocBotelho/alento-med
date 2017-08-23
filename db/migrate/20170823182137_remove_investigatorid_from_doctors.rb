class RemoveInvestigatoridFromDoctors < ActiveRecord::Migration[5.0]
  def change
    remove_column :doctors, :investigatorid, :string
  end
end
