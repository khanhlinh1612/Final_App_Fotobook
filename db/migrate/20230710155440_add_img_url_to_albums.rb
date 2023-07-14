class AddImgUrlToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :image, :string
  end
end
