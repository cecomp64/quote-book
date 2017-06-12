class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :person_id, :integer
    drop_join_table :users, :votes
  end
end
