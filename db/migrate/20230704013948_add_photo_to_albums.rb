class AddPhotoToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_reference :photos, :album
  end
end
