class CreateManages < ActiveRecord::Migration[7.0]
  def change
    create_table :manages do |t|
      t.references :admin_id, foreign_key: {to_table: :adminss}
      t.references :user
      t.timestamps
    end
  end
end
