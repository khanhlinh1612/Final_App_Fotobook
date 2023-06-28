class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.enum :sharing_mode, enum_type: :mode, default: "public" , null:false
      t.string :image_url
      t.integer :total_like

      t.timestamps
    end
  end
end
