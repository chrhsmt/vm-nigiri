class ChangeKeysColumnTypes < ActiveRecord::Migration
  def change
    change_column :keys, :public_key,  :string
    change_column :keys, :private_key, :string
  end
end
