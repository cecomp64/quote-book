class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :quote_id
      t.integer :value

      t.timestamps
    end

    add_column :quotes, :score, :integer

    add_index :votes, :user_id
    add_index :votes, :quote_id
    add_index :quotes, :score
    add_index :quotes, :attribution
    add_index :quotes, :author

    create_join_table :users, :votes
    create_join_table :quotes, :votes
  end
end
