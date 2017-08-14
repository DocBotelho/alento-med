class CreateTreatments < ActiveRecord::Migration[5.0]
  def change
    create_table :treatments do |t|
      t.references :user, foreign_key: true
      t.references :trial, foreign_key: true
      t.references :institution, foreign_key: true
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
