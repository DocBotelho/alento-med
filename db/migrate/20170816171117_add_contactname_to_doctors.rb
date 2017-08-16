class AddContactnameToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :contactname, :string
  end
end
