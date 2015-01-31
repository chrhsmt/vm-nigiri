class AddRangeToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :ip_range, :string
  end
end
