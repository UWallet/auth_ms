class CreateValidTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :valid_tokens do |t|

      t.timestamps
    end
  end
end
