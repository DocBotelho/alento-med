class AddCrmToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :crm, :string
  end
end
