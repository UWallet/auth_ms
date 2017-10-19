class CreateGroupKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :group_keys do |t|
      t.string :notification_key
      t.integer :user_id
    end
     add_index :group_keys, :user_id
  end
end
