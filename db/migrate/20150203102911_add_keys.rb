class AddKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :name
      t.integer :public_key
      t.integer :private_key
      t.timestamps
    end
    add_index :keys, :name
  end
end
