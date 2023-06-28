class CreateManages < ActiveRecord::Migration[7.0]
  def change
    create_table :manages do |t|
      t.references
      t.timestamps
    end
  end
end
