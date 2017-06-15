class AddScoreToBandNames < ActiveRecord::Migration
  def change
    add_column :band_names, :score, :integer, default: 0
    add_column :votes, :band_name_id, :integer
    add_index :votes, :band_name_id
  end
end
