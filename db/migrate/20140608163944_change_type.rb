class ChangeType < ActiveRecord::Migration
  def change
    change_column :calls, :referer, :text
  end
end
