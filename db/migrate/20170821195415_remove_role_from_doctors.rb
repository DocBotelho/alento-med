class RemoveRoleFromDoctors < ActiveRecord::Migration[5.0]
  def change
    remove_column :doctors, :role, :string
  end
end
