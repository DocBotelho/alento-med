class CreateInstitutiondoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :institutiondoctors do |t|
      t.references :institution, foreign_key: true
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
