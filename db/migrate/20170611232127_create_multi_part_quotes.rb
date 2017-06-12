class CreateMultiPartQuotes < ActiveRecord::Migration
  def change
    create_table :multi_part_quotes do |t|

      t.timestamps
    end
  end
end
