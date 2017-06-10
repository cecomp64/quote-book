class AddNumQuotesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :num_quotes, :integer
    add_index :people, :num_quotes
  end
end
