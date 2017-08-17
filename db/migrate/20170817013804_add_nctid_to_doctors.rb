class AddNctidToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :doctor_nct_id, :string
  end
end
