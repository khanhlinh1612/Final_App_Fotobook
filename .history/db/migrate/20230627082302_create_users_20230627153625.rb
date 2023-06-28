class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :user_status, ["active","inactive"]
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :avatar_url
      t.enum :status, enum_type: :user_status, default: "draft", null: false
      t.timestamps :last_login
      t.timestamps
    end
  end
end
