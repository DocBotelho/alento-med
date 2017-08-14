class CreateTrialinstitutions < ActiveRecord::Migration[5.0]
  def change
    create_table :trialinstitutions do |t|
      t.references :trial, foreign_key: true
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
