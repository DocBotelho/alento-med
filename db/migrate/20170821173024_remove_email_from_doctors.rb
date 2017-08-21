class RemoveEmailFromDoctors < ActiveRecord::Migration[5.0]
  def change
    remove_column :doctors, :email, :string
  end
end
