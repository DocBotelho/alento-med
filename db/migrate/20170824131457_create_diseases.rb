class CreateDiseases < ActiveRecord::Migration[5.0]
  def change
    create_table :diseases do |t|
      t.string :english
      t.string :portuguese

      t.timestamps
    end
  end
end
