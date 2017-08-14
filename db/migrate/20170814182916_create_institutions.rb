class CreateInstitutions < ActiveRecord::Migration[5.0]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitutde

      t.timestamps
    end
  end
end
