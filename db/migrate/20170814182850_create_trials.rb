class CreateTrials < ActiveRecord::Migration[5.0]
  def change
    create_table :trials do |t|
      t.string :title
      t.string :condition
      t.text :description
      t.text :eligibility

      t.timestamps
    end
  end
end
