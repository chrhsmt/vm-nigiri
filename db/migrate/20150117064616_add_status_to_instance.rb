class AddStatusToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :status, :string
  end
end
