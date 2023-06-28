class CreateManages < ActiveRecord::Migration[7.0]
  def change
    create_table :manages do |t|

      t.timestamps
    end
  end
end
