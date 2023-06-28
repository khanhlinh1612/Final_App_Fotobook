class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_enum :mode, ["public", "private"]
    create_table :photos do |t|
      t.string :title
      t.string :description
      t
      t.timestamps
    end
  end
end
