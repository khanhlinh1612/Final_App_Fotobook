class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.boolean :is_admin
      t.string :first_name
      t.string :last_name
      # t.string :email
      t.string :password
      t.string :avatar_url
      t.integer :status, default: 1
      t.timestamp :last_login
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
