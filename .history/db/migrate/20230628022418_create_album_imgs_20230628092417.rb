class CreateAlbumImgs < ActiveRecord::Migration[7.0]
  def change
    create_table :album_imgs do |t|

      t.timestamps
    end
  end
end
