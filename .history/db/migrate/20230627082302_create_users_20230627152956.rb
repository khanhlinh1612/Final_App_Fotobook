class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :avatar_url
      t.column :status, :enum,  enum_type: 'status_enum',default: 'active', enum: ['active', 'inactive']
      t.datetime :last_login
      t.timestamps
    end
  end
end
