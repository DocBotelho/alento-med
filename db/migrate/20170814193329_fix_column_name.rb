class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :institutions, :longitutde, :longitude
  end
end
