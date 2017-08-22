class AddFacilityidToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :facility_id, :string
  end
end
