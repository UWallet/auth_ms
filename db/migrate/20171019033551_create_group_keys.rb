class CreateGroupKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :group_keys, id: false do |t|
      t.string :notification_key, primary_key: true
      t.integer :user_id
    end
     add_index :group_keys, :user_id
  end
end
