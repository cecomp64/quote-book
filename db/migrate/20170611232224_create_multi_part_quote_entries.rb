class CreateMultiPartQuoteEntries < ActiveRecord::Migration
  def change
    create_table :multi_part_quote_entries do |t|
      t.integer :quote_id
      t.integer :order
      t.integer :multi_part_quote_id

      t.timestamps
    end
  end
end
