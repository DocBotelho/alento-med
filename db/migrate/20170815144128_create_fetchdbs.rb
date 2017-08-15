class CreateFetchdbs < ActiveRecord::Migration[5.0]
  def change
    create_table :fetchdbs do |t|

      t.timestamps
    end
  end
end
