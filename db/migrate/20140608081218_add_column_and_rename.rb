class AddColumnAndRename < ActiveRecord::Migration
  def change
    add_column :users, :sid, :string
    add_column :users, :status, :string
    add_index :users, :sid

    rename_table :users, :calls
  end
end
