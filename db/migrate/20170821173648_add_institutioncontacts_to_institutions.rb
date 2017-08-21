class AddInstitutioncontactsToInstitutions < ActiveRecord::Migration[5.0]
  def change
    add_column :institutions, :institutioncontacts, :string
  end
end
