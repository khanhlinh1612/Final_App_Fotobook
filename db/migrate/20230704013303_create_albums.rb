class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.integer :sharing_status
      t.belongs_to :user
      t.timestamps
    end
  end
end
