class AddTelnetPortToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :telnet_port, :integer
  end
end
