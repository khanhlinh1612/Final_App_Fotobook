class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.bigint :follower_id
      t.bigint :followee_id

      t.timestamps
    end
  add_foreign_key :follows, :users, column: follower_id
  add_foreign_key :follows, :users, column: followee_id
  add_index :follows, :follower_id
  add_index :follows, :followee_id
  end
end
