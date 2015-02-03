class AddKeyRelation < ActiveRecord::Migration
  def change
    add_column :instances, :key_id, :integer
  end
end
