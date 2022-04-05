class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :price
      t.string :name
      t.string :author

      t.timestamps
    end
  end
end
