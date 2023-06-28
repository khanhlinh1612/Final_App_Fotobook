class CreateAlbumImgs < ActiveRecord::Migration[7.0]
  def change
    create_table :album_imgs do |t|
      t.references :album_id, foreign_key: {to_table: albums}
      t.timestamps
    end
  end
end
