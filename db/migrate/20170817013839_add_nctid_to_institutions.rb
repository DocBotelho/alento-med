class AddNctidToInstitutions < ActiveRecord::Migration[5.0]
  def change
    add_column :institutions, :institution_nct_id, :string
  end
end
