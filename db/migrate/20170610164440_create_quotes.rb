class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :text
      t.integer :attribution
      t.integer :author

      t.timestamps
    end
  end
end
