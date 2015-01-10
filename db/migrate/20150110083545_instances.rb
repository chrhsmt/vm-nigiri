class Instances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.string :name
      t.integer :disk_size
      t.integer :memory
      t.string :ip
      t.string :mac
      t.timestamps
    end
    add_index :instances, :name
    add_index :instances, :ip
  end
end
