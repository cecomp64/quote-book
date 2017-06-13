class AddIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :multi_part_quote_id, :integer
    remove_column :votes, :quote_id
  end
end
