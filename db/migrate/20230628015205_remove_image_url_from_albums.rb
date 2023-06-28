class RemoveImageUrlFromAlbums < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :image_url, :string
  end
end
