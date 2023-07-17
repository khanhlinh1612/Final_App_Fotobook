class AddTotalHeartToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :total_heart, :integer
  end
end
