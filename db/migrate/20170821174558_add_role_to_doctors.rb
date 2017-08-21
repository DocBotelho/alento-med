class AddRoleToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :role, :string
  end
end
