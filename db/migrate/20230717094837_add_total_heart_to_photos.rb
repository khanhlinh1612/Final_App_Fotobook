class AddTotalHeartToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :total_heart, :integer
  end
end
