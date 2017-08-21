class AddFacilityidToInstitutions < ActiveRecord::Migration[5.0]
  def change
    add_column :institutions, :facility_id, :string
  end
end
