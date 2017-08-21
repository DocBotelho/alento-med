class RemoveContactFromDoctors < ActiveRecord::Migration[5.0]
  def change
    remove_column :doctors, :contactname, :string
  end
end
