class CreateContains < ActiveRecord::Migration[7.0]
  def change
    create_table :contains do |t|

      t.timestamps
    end
  end
end
