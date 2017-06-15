class CreateBandNames < ActiveRecord::Migration
  def change
    create_table :band_names do |t|
      t.text :name
      t.integer :person_id

      t.timestamps
    end

    add_index :band_names, :person_id
  end
end
