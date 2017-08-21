class RemovePhoneFromDoctors < ActiveRecord::Migration[5.0]
  def change
    remove_column :doctors, :phone, :string
  end
end
