class AddMachines < ActiveRecord::Migration
  def change

    create_table :machines do |t|
      t.string :name
      t.integer :disk_size
      t.integer :memory
      t.string :ip
      t.timestamps
    end

    add_column :instances, :machine_id, :integer
  end
end
