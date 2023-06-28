class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.bigint :folloer_id
      t.bigint :followee_:id

      t.timestamps
    end
  add_foreign_key :follows, :users, column: follower_id
  add_foreign_key :follows, :users, column: follower_id

  end
end
