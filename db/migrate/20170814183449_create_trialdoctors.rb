class CreateTrialdoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :trialdoctors do |t|
      t.references :trial, foreign_key: true
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
