class CreateContains < ActiveRecord::Migration[7.0]
  def change
    create_table :contains do |t|
      t.references :album_id, foreign_key: {to_table: :albums}
      t.references :photo_id, foreign_key: {to_table: :photos}
      t.timestamps
    end
  end
end
