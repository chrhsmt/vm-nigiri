class AddUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :ip
      t.string :tel
      t.string :referer
      t.string :user_agent
      t.timestamps
    end
  end
end
