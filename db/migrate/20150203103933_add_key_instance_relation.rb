class AddKeyInstanceRelation < ActiveRecord::Migration
  def change
    add_column :keys, :instance_id, :integer
  end
end
